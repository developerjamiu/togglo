import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/feature_toggle.dart';
import '../services/globe_kv_service.dart';

class FeatureToggleHandlers {
  final GlobeKVService _service;

  FeatureToggleHandlers(this._service);

  Router get router {
    final router = Router();

    // Create a new feature toggle
    router.post('/toggles', _createToggle);

    // Get all feature toggles
    router.get('/toggles', _getAllToggles);

    // Get a specific feature toggle
    router.get('/toggles/<id>', _getToggle);

    // Update a feature toggle
    router.put('/toggles/<id>', _updateToggle);

    // Delete a feature toggle
    router.delete('/toggles/<id>', _deleteToggle);

    // Check if a feature is enabled
    router.get('/toggles/<id>/enabled', _isEnabled);

    return router;
  }

  Future<Response> _createToggle(Request request) async {
    try {
      final payload = await request.readAsString();
      final data = json.decode(payload);

      final toggle = FeatureToggle.create(
        name: data['name'],
        description: data['description'],
        enabled: data['enabled'] ?? false,
        rules: data['rules'],
      );

      await _service.set(toggle);

      return Response.ok(
        json.encode(toggle.toJson()),
        headers: {'content-type': 'application/json'},
      );
    } catch (e) {
      return Response.internalServerError(
        body: json.encode({'error': e.toString()}),
        headers: {'content-type': 'application/json'},
      );
    }
  }

  Future<Response> _getAllToggles(Request request) async {
    try {
      final toggles = await _service.getAll();
      return Response.ok(
        json.encode(toggles.map((t) => t.toJson()).toList()),
        headers: {'content-type': 'application/json'},
      );
    } catch (e) {
      return Response.internalServerError(
        body: json.encode({'error': e.toString()}),
        headers: {'content-type': 'application/json'},
      );
    }
  }

  Future<Response> _getToggle(Request request, String id) async {
    try {
      final toggle = await _service.get(id);

      if (toggle == null) {
        return Response.notFound(
          json.encode({'error': 'Feature toggle not found'}),
          headers: {'content-type': 'application/json'},
        );
      }

      return Response.ok(
        json.encode(toggle.toJson()),
        headers: {'content-type': 'application/json'},
      );
    } catch (e) {
      return Response.internalServerError(
        body: json.encode({'error': e.toString()}),
        headers: {'content-type': 'application/json'},
      );
    }
  }

  Future<Response> _updateToggle(Request request, String id) async {
    try {
      final existingToggle = await _service.get(id);

      if (existingToggle == null) {
        return Response.notFound(
          json.encode({'error': 'Feature toggle not found'}),
          headers: {'content-type': 'application/json'},
        );
      }

      final payload = await request.readAsString();
      final data = json.decode(payload);

      final updatedToggle = existingToggle.copyWith(
        name: data['name'],
        description: data['description'],
        enabled: data['enabled'],
        rules: data['rules'],
      );

      await _service.set(updatedToggle);

      return Response.ok(
        json.encode(updatedToggle.toJson()),
        headers: {'content-type': 'application/json'},
      );
    } catch (e) {
      return Response.internalServerError(
        body: json.encode({'error': e.toString()}),
        headers: {'content-type': 'application/json'},
      );
    }
  }

  Future<Response> _deleteToggle(Request request, String id) async {
    try {
      final toggle = await _service.get(id);

      if (toggle == null) {
        return Response.notFound(
          json.encode({'error': 'Feature toggle not found'}),
          headers: {'content-type': 'application/json'},
        );
      }

      await _service.delete(id);

      return Response.ok(
        json.encode({'message': 'Feature toggle deleted successfully'}),
        headers: {'content-type': 'application/json'},
      );
    } catch (e) {
      return Response.internalServerError(
        body: json.encode({'error': e.toString()}),
        headers: {'content-type': 'application/json'},
      );
    }
  }

  Future<Response> _isEnabled(Request request, String id) async {
    try {
      final isEnabled = await _service.isEnabled(id);

      return Response.ok(
        json.encode({'enabled': isEnabled}),
        headers: {'content-type': 'application/json'},
      );
    } catch (e) {
      return Response.internalServerError(
        body: json.encode({'error': e.toString()}),
        headers: {'content-type': 'application/json'},
      );
    }
  }
}
