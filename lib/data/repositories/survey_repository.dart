import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../models/survey.dart';
import '../../services/auth_service.dart';
import '../app_database.dart';

/// CRUD local de levantamentos sobre o Drift.
///
/// Nenhuma chamada ao Supabase acontece aqui: a sincronização será ligada em
/// etapa posterior. Com `kDevBypassAuth = true`, `AuthService.currentUserId`
/// retorna null; a coluna local `user_id` é anulável e aceita isso, mas o RLS
/// do Supabase ainda exigirá um usuário real quando a sync for ativada.
class SurveyRepository {
  SurveyRepository(this._db, {AuthService? authService, Uuid? uuid})
      : _authService = authService ?? AuthService(),
        _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final AuthService _authService;
  final Uuid _uuid;

  /// Levantamentos ativos, do mais recente para o mais antigo.
  Stream<List<Survey>> watchAllSurveys() {
    final query = _db.select(_db.surveys)
      ..where((row) => row.deleted.equals(false))
      ..orderBy([
        (row) => OrderingTerm.desc(row.updatedAt),
        (row) => OrderingTerm.desc(row.createdAt),
      ]);
    return query.watch();
  }

  /// Levantamento ativo mais recente, usado pelo card "Último levantamento".
  Future<Survey?> getLatestSurvey() {
    final query = _db.select(_db.surveys)
      ..where((row) => row.deleted.equals(false))
      ..orderBy([
        (row) => OrderingTerm.desc(row.updatedAt),
        (row) => OrderingTerm.desc(row.createdAt),
      ])
      ..limit(1);
    return query.getSingleOrNull();
  }

  /// Busca um levantamento ativo pelo id. Excluídos logicamente são ignorados.
  Future<Survey?> getSurveyById(String id) {
    final query = _db.select(_db.surveys)
      ..where((row) => row.id.equals(id) & row.deleted.equals(false))
      ..limit(1);
    return query.getSingleOrNull();
  }

  /// Cria um levantamento local com id UUID e datas em UTC.
  Future<void> createSurvey({
    required String name,
    required String description,
  }) async {
    final DateTime now = DateTime.now().toUtc();
    final String trimmedName = name.trim();
    final String trimmedDescription = description.trim();
    final Survey survey = Survey(
      id: _uuid.v4(),
      userId: _authService.currentUserId,
      name: trimmedName,
      description: trimmedDescription.isEmpty ? null : trimmedDescription,
      createdAt: now,
      updatedAt: now,
      deleted: false,
    );
    await _db.into(_db.surveys).insert(survey.toCompanion());
  }

  /// Atualiza nome/descrição de um levantamento local.
  ///
  /// Como a exclusão é lógica, este método não altera [Survey.deleted].
  Future<void> updateSurvey(
    String id, {
    required String name,
    String? description,
  }) async {
    final String trimmedDescription = description?.trim() ?? '';
    await (_db.update(_db.surveys)..where((row) => row.id.equals(id))).write(
      SurveysCompanion(
        name: Value(name.trim()),
        description: Value<String?>(
          trimmedDescription.isEmpty ? null : trimmedDescription,
        ),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  /// Registra a finalização no banco local.
  ///
  /// O schema atual não possui coluna de status; por isso a finalização é
  /// gravada em `updatedAt` até existir um campo próprio. O registro não é
  /// excluído: exclusão continua sendo lógica via [softDeleteSurvey].
  Future<void> finalizeSurvey(String id) async {
    await (_db.update(_db.surveys)..where((row) => row.id.equals(id))).write(
      SurveysCompanion(
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  /// Exclusão lógica: nunca remove a linha do banco.
  Future<void> softDeleteSurvey(String id) async {
    await (_db.update(_db.surveys)..where((row) => row.id.equals(id))).write(
      SurveysCompanion(
        deleted: const Value(true),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }
}
