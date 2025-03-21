import 'package:dotenv/dotenv.dart';

class Environment {
  static final Environment _instance = Environment._internal();
  late final DotEnv _dotenv;

  factory Environment() {
    return _instance;
  }

  Environment._internal() {
    _dotenv = DotEnv(includePlatformEnvironment: true)..load();
  }

  String get globeNamespace => _dotenv['GLOBE_NAMESPACE'] ?? '';
  String get globeBaseUrl => _dotenv['GLOBE_BASE_URL'] ?? '';
  String get port => _dotenv['PORT'] ?? '';
}
