import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

/*
  @method: This widget is for create a space to upload music.
 */
class UploadInvoiceBoxWidget extends StatelessWidget {
  final VoidCallback onFileSelected;

  const UploadInvoiceBoxWidget({super.key, required this.onFileSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E24),
        border: Border.all(color: const Color(0xFF4C3E56), width: 2),
      ),
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFF121116),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.cloud_upload_outlined,
            color: Colors.blueAccent,
            size: 30,
          ),
        ),

        const SizedBox(height: 15),

        Text(
          FlutterI18n.translate(context, "upload_song"),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          FlutterI18n.translate(context, "upload_song_instruction"),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
