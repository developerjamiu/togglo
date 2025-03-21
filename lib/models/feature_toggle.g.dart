// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_toggle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureToggle _$FeatureToggleFromJson(Map<String, dynamic> json) =>
    FeatureToggle(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      enabled: json['enabled'] as bool,
      rules: json['rules'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FeatureToggleToJson(FeatureToggle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'enabled': instance.enabled,
      'rules': instance.rules,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
