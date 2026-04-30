import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FileUtils {

  static int LimitFileSize = 1000000;

  static Future<PlatformFile?> pickFileTypeMusic() async{
    try{
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.audio,
        allowMultiple: false
      );
      return result?.files.first;
    }catch (e){
      print("Error al seleccionar archivo: $e");
    }
  }

  static String GetFileName(File file, int? limit){
    String nameFile = file.path.split('/').last;
    return nameFile;

  }

}

