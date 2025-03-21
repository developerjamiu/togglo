import 'dart:convert';
import 'package:globe_kv/globe_kv.dart';
import '../models/feature_toggle.dart';
import '../config/environment.dart';

class GlobeKVService {
  final GlobeKV _kv;
  final String _prefix = 'feature_toggle:';

  GlobeKVService() : _kv = GlobeKV(Environment().globeNamespace);

  String _getKey(String id) {
    return '$_prefix$id';
  }

  Future<void> set(FeatureToggle toggle) async {
    final key = _getKey(toggle.id);
    final value = jsonEncode(toggle.toJson());

    await _kv.set(key, value);
  }

  Future<FeatureToggle?> get(String id) async {
    final key = _getKey(id);
    final value = await _kv.getString(key);

    if (value == null) return null;

    try {
      return FeatureToggle.fromJson(json.decode(value));
    } catch (e) {
      print('Error decoding feature toggle: $e');
      return null;
    }
  }

  Future<List<FeatureToggle>> getAll() async {
    final result = await _kv.list(prefix: _prefix);
    final toggles = <FeatureToggle>[];

    for (final item in result.results) {
      final value = await _kv.getString(item.key);
      if (value != null) {
        try {
          toggles.add(FeatureToggle.fromJson(json.decode(value)));
        } catch (e) {
          print('Error decoding feature toggle: $e');
          // Skip invalid entries
        }
      }
    }

    return toggles;
  }

  Future<void> delete(String id) async {
    final key = _getKey(id);
    await _kv.delete(key);
  }

  Future<bool> isEnabled(String id) async {
    final toggle = await get(id);
    return toggle?.enabled ?? false;
  }
}
