import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:syncable/syncable.dart';

import '../data/app_database.dart';

/// Levantamento. A exclusão é lógica via [deleted], nunca física.
class Survey extends Equatable implements Syncable {
  const Survey({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
      deleted: json['deleted'] as bool? ?? false,
    );
  }

  @override
  final String id;
  @override
  final String? userId;
  final String name;
  final String? description;
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final bool deleted;

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        description,
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
        'name': name,
        'description': description,
        'created_at': createdAt.toUtc().toIso8601String(),
        'updated_at': updatedAt.toUtc().toIso8601String(),
        'deleted': deleted,
      };

  @override
  UpdateCompanion<Survey> toCompanion() {
    return SurveysCompanion.insert(
      id: Value(id),
      userId: Value(userId),
      name: name,
      description: Value(description),
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
