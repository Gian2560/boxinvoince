import os
import uuid
import aiofiles
from fastapi import FastAPI, UploadFile, File, HTTPException
from fastapi.responses import FileResponse, JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from .tasks import transcribe_task
from celery.result import AsyncResult
from .tasks import process_karaoke_audio

#inicializamos la aplicación FastAPI

app = FastAPI(title="File Processing API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

UPLOAD_DIR = "uploads"
if not os.path.exists(UPLOAD_DIR):
    os.makedirs(UPLOAD_DIR)


@app.post("/transcribe",status_code=202)

async def start_transcripcion(file: UploadFile = File(...)):
    """
    Endpoint to upload a file for transcription.
    """
    if not file.filename.endswith(('.mp3', '.wav', '.m4a')):
        raise HTTPException(status_code=400, detail="Invalid file type. Only mp3, wav, and m4a are allowed.")

    #Creamos 
    job_id = str(uuid.uuid4())
    file_extension = os.path.splitext(file.filename)[1]
    file_path = os.path.join(UPLOAD_DIR, f"{job_id}{file_extension}")

    try:
        async with aiofiles.open(file_path, "wb") as buffer:
            content = await file.read()
            await buffer.write(content)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to save file: {e}")

    # ✅ ESTO ESTÁ BIEN (Es la tarea nueva con Demucs)
    process_karaoke_audio.apply_async(args=[file_path, job_id], task_id=job_id)

    return {
            "status": "pending",
            "job_id": job_id,
            "message": "Archivo recibido. El procesamiento ha comenzado."
        }

@app.get("/result/{job_id}")
async def get_result(job_id: str):
    """
    Consulta el estado de la tarea en el Result Backend (Redis).
    """
    task_result = AsyncResult(job_id)

    if task_result.state == 'PENDING':
        # En Celery, 'PENDING' puede significar que la tarea no existe o está en cola
        return {"status": "processing", "result": None}
    
    elif task_result.state == 'SUCCESS':
        return {
            "status": "completed",
            "result": task_result.result 
        }
    
    elif task_result.state == 'FAILURE':
        return {
            "status": "failed",
            "error": str(task_result.info) # 'info' contiene la excepción en caso de fallo
        }

    return {"status": task_result.state}


@app.get("/download/{job_id}")
async def download_instrumental(job_id: str):
    """
    Sirve el archivo de audio instrumental que Demucs guardó en el disco.
    """
    # Esta ruta coincide exactamente con donde Demucs escupe el archivo en tasks.py
    instrumental_path = os.path.join(UPLOAD_DIR, "separated", job_id, "htdemucs", job_id, "no_vocals.wav")
    
    if not os.path.exists(instrumental_path):
        raise HTTPException(status_code=404, detail="El archivo instrumental no existe o aún no termina.")
        
    # FileResponse lee el archivo del disco y lo manda directo como audio
    return FileResponse(
        path=instrumental_path, 
        media_type="audio/wav", 
        filename=f"instrumental_{job_id}.wav"
    )