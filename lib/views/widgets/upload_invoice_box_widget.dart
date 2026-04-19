import 'package:app/config/colors_config.dart';
import 'package:app/views/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class UploadInvoiceBoxWidget extends StatelessWidget {
  final VoidCallback onFileSelected;

  const UploadInvoiceBoxWidget({super.key, required this.onFileSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ColorsConfig.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ColorsConfig.cardBorderWithOpacity, width: 1.5),
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
}