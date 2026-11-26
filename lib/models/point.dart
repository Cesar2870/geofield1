import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:syncable/syncable.dart';

import '../data/app_database.dart';

/// Ponto capturado dentro de um levantamento.
class SurveyPoint extends Equatable implements Syncable {
  const SurveyPoint({
    required this.id,
    required this.userId,
    required this.surveyId,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    required this.source,
    required this.capturedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
  });

  factory SurveyPoint.fromJson(Map<String, dynamic> json) {
    return SurveyPoint(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      surveyId: json['survey_id'] as String,
      latitude: _parseDouble(json['latitude']),
      longitude: _parseDouble(json['longitude']),
      accuracy: _parseNullableDouble(json['accuracy']),
      source: json['source'] as String,
      capturedAt: _parseDate(json['captured_at']),
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
      deleted: json['deleted'] as bool? ?? false,
    );
  }

  @override
  final String id;
  @override
  final String? userId;
  final String surveyId;
  final double latitude;
  final double longitude;
  final double? accuracy;

  /// `manual` ou `automatic`.
  final String source;
  final DateTime capturedAt;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final bool deleted;

  @override
  List<Object?> get props => [
        id,
        userId,
        surveyId,
        latitude,
        longitude,
        accuracy,
        source,
        capturedAt,
        createdAt,
        updatedAt,
        deleted,
      ];

  @override
  bool get stringify => true;

  /// Chaves em snake_case para corresponder ao schema do Supabase.
  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'survey_id': surveyId,
        'latitude': latitude,
        'longitude': longitude,
        'accuracy': accuracy,
        'source': source,
        'captured_at': capturedAt.toUtc().toIso8601String(),
        'created_at': createdAt.toUtc().toIso8601String(),
        'updated_at': updatedAt.toUtc().toIso8601String(),
        'deleted': deleted,
      };

  @override
  UpdateCompanion<SurveyPoint> toCompanion() {
    return PointsCompanion.insert(
      id: Value(id),
      userId: Value(userId),
      surveyId: surveyId,
      latitude: latitude,
      longitude: longitude,
      accuracy: Value(accuracy),
      source: source,
      capturedAt: capturedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deleted: Value(deleted),
    );
  }
}

DateTime _parseDate(Object? value) {
  if (value is DateTime) return value.toUtc();
  if (value is String) return DateTime.parse(value).toUtc();
  throw FormatException('Data inválida recebida do backend.', value);
}

double _parseDouble(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.parse(value);
  throw FormatException('Número inválido recebido do backend.', value);
}

double? _parseNullableDouble(Object? value) =>
    value == null ? null : _parseDouble(value);
