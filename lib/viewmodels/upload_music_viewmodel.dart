import 'dart:io';

import 'package:app/data/models/lyrics_result.dart';
import 'package:app/data/repositories/audio_repository.dart';
import 'package:app/utils/file_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class Uploadmusicviewmodel extends ChangeNotifier{
  final AudioRepository _repository = AudioRepository();
  File? _selectedMusic;
  bool _isProcessing = false;
  String messageLoading = "";
  String auxiliaryMessageLoading = "";
  LyricsResult? _finalResult;


  Future<void> processAudio(String path) async{
    _isProcessing = true;
    messageLoading = "uploading_audio";
    auxiliaryMessageLoading="key_message_waiting_process_1";
    notifyListeners();

    try{
      final jobResponse = await _repository.startProcessingFile(path);
      await _pollResult(jobResponse!.runpodId);
    }
    catch(e){
      _isProcessing = false;
      notifyListeners();
    }
  }

  Future<void> _pollResult(String runpodId) async {
    bool isDone = false;
    messageLoading="processing_audio";
    auxiliaryMessageLoading="key_message_waiting_process_2";
    notifyListeners();
    while (!isDone) {
      await Future.delayed(const Duration(seconds: 5));

      final polling = await _repository.checkStatus(runpodId);

      if (polling.status == "completed") {
        _finalResult = polling.result;
        isDone = true;
      } else if (polling.status == "failed") {
        isDone = true;
      }
    }

    _isProcessing = false;
    notifyListeners();
  }


  Future<void> selectPrepareAudio() async {

    final PlatformFile? pickedFile = await FileUtils.pickFileTypeMusic();

    if(pickedFile == null)return;

    if(pickedFile.size > FileUtils.LimitFileSize*1024){
      print("El archivo es demasiado grande");
      return;
    }
    _selectedMusic = File(pickedFile.path!);
    notifyListeners();
  }

  String get fileName => _selectedMusic != null
      ? FileUtils.GetFileName(_selectedMusic!, null)
      : "";

  void removeFile(){
    _selectedMusic = null;
    notifyListeners();
  }

  File? get selectedMusic => _selectedMusic;
  bool get isProcessing => _isProcessing;
  LyricsResult? get finalResult => _finalResult;
}