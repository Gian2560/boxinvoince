class Environment {

  static const String baseUrl = String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'http://10.0.2.2'
  );

  static const String port = String.fromEnvironment(
      'PORT',
      defaultValue: '8080'
  );

  static const int connectionDuration = 15;
  static String get apiAudioUrl => '$baseUrl:$port/audio';
}