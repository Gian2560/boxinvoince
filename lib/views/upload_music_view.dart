import 'package:app/config/box_routes.dart';
import 'package:app/config/colors_config.dart';
import 'package:app/utils/animation_utils.dart';
import 'package:app/viewmodels/upload_music_viewmodel.dart';
import 'package:app/views/layout/base_layout.dart';
import 'package:app/views/widgets/upload_invoice_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

class UploadMusicView extends StatefulWidget {
  const UploadMusicView({super.key});

  @override
  State<UploadMusicView> createState() => _UploadMusicViewState();
}

class _UploadMusicViewState extends State<UploadMusicView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<Uploadmusicviewmodel>();

    if (!vm.isProcessing && vm.finalResult != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(
          context,
          BoxRoutes.playKaraoke,
          arguments: vm.finalResult,
        );
      });
    }

    return BaseLayout(
      title: FlutterI18n.translate(context, "title_project"),
      child: vm.isProcessing
          ? _buildLoadingState(
              context,
              vm.messageLoading,
              vm.auxiliaryMessageLoading,
            )
          : UploadInvoiceBoxWidget(
              uploadedMusic: vm.selectedMusic,
              displayTitle: vm.fileName,
              onFileSelected: () {
                vm.selectPrepareAudio();
              },
              onRemove: vm.removeFile,
            ),
    );
  }

  Widget _buildLoadingState(
    BuildContext context,
    String mainMessage,
    String secondaryMessage,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 52, horizontal: 32),
      decoration: BoxDecoration(
        color: ColorsConfig.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: ColorsConfig.cardBorderWithOpacity,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Spinner
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: ColorsConfig.surfaceIcon,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RotationTransition(
                turns: _controller,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  backgroundColor: ColorsConfig.surfaceIcon,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorsConfig.brandPurple,
                  ),
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                FlutterI18n.translate(context, mainMessage),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: ColorsConfig.textPrimary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(width: 4),
              AnimationUtils().buildDotsAnimation(_controller, context),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            FlutterI18n.translate(context, secondaryMessage),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: ColorsConfig.textSecondary,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
