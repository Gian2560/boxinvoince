import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class I18nConfig {
  static const List<Locale> supportedLocales = [Locale('es'), Locale('en')];

  static Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            useCountryCode: false,
            fallbackFile: 'es',
            basePath: 'assets/i18n',
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
}
