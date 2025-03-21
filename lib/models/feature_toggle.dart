import 'package:json_annotation/json_annotation.dart';

part 'feature_toggle.g.dart';

@JsonSerializable()
class FeatureToggle {
  final String id;
  final String name;
  final String description;
  final bool enabled;
  final Map<String, dynamic>? rules;
  final DateTime createdAt;
  final DateTime updatedAt;

  FeatureToggle({
    required this.id,
    required this.name,
    required this.description,
    required this.enabled,
    this.rules,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FeatureToggle.create({
    required String name,
    required String description,
    bool enabled = false,
    Map<String, dynamic>? rules,
  }) {
    final now = DateTime.now();
    return FeatureToggle(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      enabled: enabled,
      rules: rules,
      createdAt: now,
      updatedAt: now,
    );
  }

  factory FeatureToggle.fromJson(Map<String, dynamic> json) =>
      _$FeatureToggleFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureToggleToJson(this);

  FeatureToggle copyWith({
    String? name,
    String? description,
    bool? enabled,
    Map<String, dynamic>? rules,
  }) {
    return FeatureToggle(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      enabled: enabled ?? this.enabled,
      rules: rules ?? this.rules,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
