import 'package:app/common/box_constants.dart';
import 'package:app/data/models/audio_job_response.dart';
import 'package:app/data/models/lyrics_result.dart';
import 'package:app/data/services/audio_service.dart';
class PollingResult {
  final String status;
  final LyricsResult? result;
  final String? error;

  PollingResult({required this.status, this.result, this.error});
}
class AudioRepository {

   final AudioService _audioService = AudioService();

  Future<AudioJobResponse?> startProcessingFile(String path) async {
    final response =  await _audioService.uploadAudio(path);
    return AudioJobResponse.fromJson(response.data);
  }

  Future<PollingResult> checkStatus(String runPodId) async {
    final response =  await _audioService.getJobStatus(runPodId);
    Map<String,dynamic> responseMap = response.data;
    String status = responseMap["status"];
    
    if(StatusResponse.COMPLETED.desc.compareTo(status) == 0){
      return PollingResult(status: status,
      result: LyricsResult.fromJson(responseMap["result"]));
    }
    else if(StatusResponse.FAILED.desc.compareTo(status) == 0){
      return PollingResult(status: status,error: responseMap["error"]);
    }
    return PollingResult(status: status);
  }
}