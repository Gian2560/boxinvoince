import 'package:app/config/box_routes.dart';
import 'package:app/config/i18n_config.dart';
import 'package:app/viewmodels/upload_music_viewmodel.dart';
import 'package:app/views/box_voice_player_view.dart';
import 'package:app/views/upload_music_view.dart';
import 'package:app/views/layout/base_layout.dart';
import 'package:app/views/widgets/upload_invoice_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Uploadmusicviewmodel()),
    ],
    child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoxInVoice',
      localizationsDelegates: I18nConfig.localizationsDelegates,
      supportedLocales: I18nConfig.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: UploadMusicView(),
      initialRoute: BoxRoutes.main,
      routes: {
        BoxRoutes.main: (context) => UploadMusicView(),
        BoxRoutes.playKaraoke: (context) => BoxVoicePlayerView(),
      },
    );
  }
}
