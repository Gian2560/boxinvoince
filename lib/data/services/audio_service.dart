import 'package:app/config/enviroment.dart';
import 'package:dio/dio.dart';

class AudioService {

  final Dio _dio = Dio(BaseOptions(
    baseUrl: Environment.apiAudioUrl,
    connectTimeout: const Duration(seconds: Environment.connectionDuration),
  ));

  Future<Response> uploadAudio(String filePath) async {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: "upload.mp3"),
      });
      return await _dio.post("/transcribe", data: formData);
  }

  Future<Response> getJobStatus(String runpodId) async {
    return await _dio.get("/result/$runpodId");
  }

}