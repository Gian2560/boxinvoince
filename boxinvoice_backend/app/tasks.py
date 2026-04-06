import os
from celery import Celery
from faster_whisper import WhisperModel
import subprocess

# Configuración de Celery
celery_app = Celery(
    'karaoke_tasks',
    broker='redis://redis:6379/0',
    backend='redis://redis:6379/0'
)

celery_app.conf.update(
    task_track_started=True,
    task_serializer='json',
    result_serializer='json',
    accept_content=['json'],
)

# --- CORRECCIÓN CLAVE AQUÍ ---
# Definimos la variable global pero vacía (None)
model = None 

def load_model():
    """Función auxiliar para cargar el modelo solo si no existe"""
    global model
    if model is None:
        print("⏳ (Lazy Load) Cargando modelo Whisper en memoria del Worker...")
        model = WhisperModel("medium", device="cpu", compute_type="int8",cpu_threads=8,num_workers=4)
        print("✅ Modelo cargado y listo.")
    return model

@celery_app.task(bind=True, name="app.tasks.transcribe_task")
def transcribe_task(self, file_path: str):
    try:
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"El archivo {file_path} no existe.")

        # Llamamos a la carga del modelo AQUÍ DENTRO, no afuera.
        # Así la API (main.py) puede importar este archivo sin cargar la IA.
        whisper_instance = load_model()

        # Transcripción
        segments, info = whisper_instance.transcribe(
            file_path, 
            word_timestamps=True,
            beam_size=5,
            task="transcribe",    # <--- Asegúrate que esté alineado con 'file_path'
            vad_filter=True,
            vad_parameters=dict(min_silence_duration_ms=500)
        )

        result_data = {
            "language": info.language,
            "duration": info.duration,
            "segments": []
        }

        for segment in segments:
            seg_data = {
                "start": segment.start,
                "end": segment.end,
                "text": segment.text.strip(),
                "words": []
            }
            if segment.words:
                for word in segment.words:
                    seg_data["words"].append({
                        "word": word.word.strip(),
                        "start": word.start,
                        "end": word.end,
                        "probability": word.probability
                    })
            result_data["segments"].append(seg_data)

        # Limpieza
        if os.path.exists(file_path):
            os.remove(file_path)

        return result_data

    except Exception as e:
        print(f"Error procesando tarea: {e}")
        if os.path.exists(file_path):
            os.remove(file_path)
        raise e
    
@celery_app.task(bind=True, name="app.tasks.process_karaoke_audio")
def process_karaoke_audio(self, file_path: str, job_id: str):
    try:
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"El archivo {file_path} no existe.")

        output_dir = f"uploads/separated/{job_id}"
        
        # 1. EJECUTAR DEMUCS
        print(f"🎵 Iniciando separación de audio con Demucs para {job_id}...")
        command = [
            "demucs", 
            "--two-stems=vocals", # Separa en voz e instrumental
            "-o", output_dir, 
            file_path
        ]
        subprocess.run(command, check=True)
        
        # Rutas generadas por Demucs (usa la subcarpeta 'htdemucs')
        base_name = os.path.splitext(os.path.basename(file_path))[0]
        vocals_path = os.path.join(output_dir, "htdemucs", base_name, "vocals.wav")
        instrumental_path = os.path.join(output_dir, "htdemucs", base_name, "no_vocals.wav")

        # 2. CARGAR MODELO Y TRANSCRIBIR SOLO LAS VOCES
        print("📝 Transcribiendo voces...")
        whisper_instance = load_model()
        
        segments, info = whisper_instance.transcribe(
            vocals_path, 
            word_timestamps=True,
            beam_size=5,
            vad_filter=True,
            vad_parameters=dict(min_silence_duration_ms=500)
        )

        # 3. ESTRUCTURAR EL JSON DE SALIDA
        transcription_data = []
        for segment in segments:
            seg_data = {
                "start": segment.start,
                "end": segment.end,
                "text": segment.text.strip(),
                "words": []
            }
            if segment.words:
                for word in segment.words:
                    seg_data["words"].append({
                        "word": word.word.strip(),
                        "start": word.start,
                        "end": word.end,
                        "probability": word.probability
                    })
            transcription_data.append(seg_data)

        # 4. LIMPIEZA
        if os.path.exists(file_path):
            os.remove(file_path) # Borramos el original
        if os.path.exists(vocals_path):
            os.remove(vocals_path) # Borramos las voces aisladas
        
        return {
            "status": "completed",
            "language": info.language,
            "instrumental_path": instrumental_path, # Ruta donde quedó el instrumental
            "lyrics": transcription_data
        }

    except Exception as e:
        print(f"❌ Error procesando tarea {job_id}: {e}")
        # Intentamos limpiar el archivo original si algo falla
        if os.path.exists(file_path):
            os.remove(file_path)
        raise e