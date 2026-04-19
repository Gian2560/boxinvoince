import 'package:app/config/i18n_config.dart';
import 'package:app/views/layout/base_layout.dart';
import 'package:app/views/widgets/upload_invoice_box_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoxInVoice',
      //TODO: try to refactor the i18n config and move intro namespacefiletransaltion
      localizationsDelegates: I18nConfig.localizationsDelegates,
      supportedLocales: I18nConfig.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BaseLayout(
        title: 'BoxInVoice',
        child: UploadInvoiceBoxWidget(onFileSelected: () {}),
      ),
    );
  }
}
