import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../../data/app_database.dart';
import '../../data/repositories/survey_repository.dart';
import '../../models/survey.dart';
import '../survey_details/survey_details_screen.dart';
import 'survey_form_screen.dart';

// Tokens de DESIGN.md: #f7f7f2 (fundo), #1f2723 (texto primário),
// #68716c (texto secundário), #e2e7e2 (borda), #18583d (destaque),
// #edf1ea e 24 px de margem.
//
// A composição do card (#edf1ea + borda #e2e7e2 + raio 12 + padding 16)
// vem da descrição: o DESIGN.md traz #edf1ea como fundo de campo e #e2e7e2
// como borda, mas não define esse card.
// Título 20 px semibold, data 11 px e texto vazio 14 px vêm de DESIGN.md;
// descrição 13 px #68716c e formatação dd/MM/yyyy vêm da descrição.
const Color _colorBackground = Color(0xFFF7F7F2);
const Color _colorCard = Color(0xFFEDF1EA);
const Color _colorBorder = Color(0xFFE2E7E2);
const Color _colorPrimary = Color(0xFF18583D);
const Color _colorText = Color(0xFF1F2723);
const Color _colorSecondary = Color(0xFF68716C);
const Color _colorDanger = Color(0xFFE74C3C);

/// Aba Levantamentos: lista local, criação, edição e exclusão lógica.
class SurveysScreen extends StatefulWidget {
  const SurveysScreen({super.key});

  @override
  State<SurveysScreen> createState() => _SurveysScreenState();
}

class _SurveysScreenState extends State<SurveysScreen> {
  final SurveyRepository _repository = SurveyRepository(appDatabase);
  late final Stream<List<Survey>> _surveysStream;

  @override
  void initState() {
    super.initState();
    _surveysStream = _repository.watchAllSurveys();
  }

  Future<void> _openForm({Survey? survey}) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => SurveyFormScreen(surveyToEdit: survey),
      ),
    );
    // O StreamBuilder observa o Drift; não é necessário recarregar a lista.
  }

  void _openDetails(Survey survey) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SurveyDetailsScreen(
          surveyId: survey.id,
          surveyName: survey.name,
        ),
      ),
    );
  }

  Future<void> _confirmDelete(Survey survey) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: _colorBackground,
          title: const Text(
            'Excluir levantamento?',
            style: TextStyle(
              color: _colorText,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            'O levantamento será marcado como excluído e não aparecerá na lista.',
            style: TextStyle(
              color: _colorSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Excluir',
                style: TextStyle(color: _colorDanger),
              ),
            ),
          ],
        );
      },
    );
    if (confirmed != true) return;
    await _repository.softDeleteSurvey(survey.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Levantamentos',
                      style: TextStyle(
                        color: _colorText,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 34 / 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: IconButton(
                      onPressed: () => _openForm(),
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.add,
                        color: _colorPrimary,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Survey>>(
                stream: _surveysStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Texto estático: um indicador circular animado dentro do
                    // IndexedStack impediria pumpAndSettle nos widget tests.
                    return const Center(
                      child: Text(
                        'Carregando levantamentos...',
                        style: TextStyle(
                          color: _colorSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 20 / 14,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Não foi possível carregar os levantamentos.',
                        style: TextStyle(
                          color: _colorSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 20 / 14,
                        ),
                      ),
                    );
                  }

                  final List<Survey> surveys =
                      snapshot.data ?? const <Survey>[];
                  if (surveys.isEmpty) {
                    return const _EmptyState();
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    itemCount: surveys.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (BuildContext context, int index) {
                      final Survey survey = surveys[index];
                      return _SurveyCard(
                        survey: survey,
                        onTap: () => _openDetails(survey),
                        onEdit: () => _openForm(survey: survey),
                        onDelete: () => _confirmDelete(survey),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.map_outlined, color: _colorSecondary, size: 48),
          SizedBox(height: 12),
          Text(
            'Nenhum levantamento criado ainda.',
            style: TextStyle(
              color: _colorSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _SurveyCard extends StatelessWidget {
  const _SurveyCard({
    required this.survey,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Survey survey;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final String? description = survey.description?.trim();
    return Card(
      color: _colorCard,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _colorBorder, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            survey.name,
                            style: const TextStyle(
                              color: _colorText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (description != null && description.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _colorSecondary,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),
                          Text(
                            _formatDate(survey.createdAt),
                            style: const TextStyle(
                              color: _colorSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.chevron_right,
                      color: _colorSecondary,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onEdit,
            tooltip: 'Editar levantamento',
            icon: const Icon(Icons.edit_outlined, color: _colorPrimary),
          ),
          IconButton(
            onPressed: onDelete,
            tooltip: 'Excluir levantamento',
            icon: const Icon(Icons.delete_outline, color: _colorDanger),
          ),
        ],
      ),
    );
  }
}

/// Formatação manual para não adicionar dependências. Padrão dd/MM/yyyy
/// definido na descrição da tela.
String _formatDate(DateTime date) {
  final DateTime local = date.toLocal();
  final String day = local.day.toString().padLeft(2, '0');
  final String month = local.month.toString().padLeft(2, '0');
  return '$day/$month/${local.year}';
}
