import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:togglo/handlers/feature_toggle_handlers.dart';
import 'package:togglo/services/globe_kv_service.dart';
import 'package:togglo/config/environment.dart';
import 'dart:io';

void main() async {
  // Initialize environment configuration
  final env = Environment();

  // Parse port from environment with default
  final port = int.tryParse(env.port) ?? 8080;

  // Create the GlobeKV service with default namespace
  final service = GlobeKVService();

  // Create the feature toggle handlers
  final handlers = FeatureToggleHandlers(service);

  // Create the pipeline
  final pipeline =
      Pipeline().addMiddleware(logRequests()).addHandler(handlers.router.call);

  // Start the server
  final server = await shelf_io.serve(
    pipeline,
    InternetAddress.anyIPv4,
    port,
  );

  print('Server running on ${server.address.address}:${server.port}');
}
