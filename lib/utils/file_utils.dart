import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FileUtils {

  static int LimitFileSize = 10000;

  static Future<List<PlatformFile>?> pickFileTypeMusic() async{
    try{
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.audio,
        allowMultiple: false
      );
      return result?.files;
    }catch (e){
      print("Error al seleccionar archivo: $e");
    }
  }

}

