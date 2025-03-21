import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:togglo/handlers/feature_toggle_handlers.dart';
import 'package:togglo/services/globe_kv_service.dart';
import 'package:togglo/middleware/cors_middleware.dart';

void main() async {
  final service = GlobeKVService();
  final handlers = FeatureToggleHandlers(service);

  final pipeline = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsMiddleware())
      .addHandler(handlers.router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await shelf_io.serve(pipeline, InternetAddress.anyIPv4, port);

  print('Server running on localhost:${server.port}');
}
