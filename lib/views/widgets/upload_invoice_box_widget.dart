import 'dart:io';

import 'package:app/config/colors_config.dart';
import 'package:app/views/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class UploadInvoiceBoxWidget extends StatelessWidget {
  final VoidCallback onFileSelected;
  final VoidCallback onRemove;
  final File? uploadedMusic;
  final String displayTitle;
  const UploadInvoiceBoxWidget({
    super.key,
    required this.displayTitle,
    required this.uploadedMusic,
    required this.onFileSelected,
    required this.onRemove
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: ColorsConfig.surfaceCard,

            border: Border.all(color: ColorsConfig.cardBorderWithOpacity, width: 1.5),
          ),
          child: uploadedMusic != null ? buildBodyFile(context) : buildBodyEmpty(context),
        ),

        // Botón X en esquina superior derecha
        if (uploadedMusic != null)
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: ColorsConfig.surfaceIcon,

                  border: Border.all(color: ColorsConfig.cardBorderWithOpacity, width: 1),
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: ColorsConfig.textSecondary,
                  size: 25,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildBodyEmpty(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: ColorsConfig.surfaceIcon,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.cloud_upload_outlined,
            color: ColorsConfig.iconColor,
            size: 32,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          FlutterI18n.translate(context, "upload_song"),
          style: TextStyle(
            fontSize: 22,
            color: ColorsConfig.textPrimary,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          FlutterI18n.translate(context, "upload_song_instrucction"),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsConfig.textSecondary,
            fontSize: 13,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 28),

        CustomButtonWidget(
          text: FlutterI18n.translate(context, "select_file"),
          onPressed: onFileSelected,
        ),
      ],
    );
  }

  Widget buildBodyFile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: ColorsConfig.surfaceIcon,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.audio_file_outlined,
            color: ColorsConfig.iconColor,
            size: 32,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          displayTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: ColorsConfig.textPrimary,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "*******${FlutterI18n.translate(context, "ready_to_process")}******",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsConfig.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),

        const SizedBox(height: 28),

        CustomButtonWidget(
          text: FlutterI18n.translate(context, "start"),
          onPressed:  () {},
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
