import 'package:material_ui/material_ui.dart';

import '../../data/app_database.dart';
import '../../data/repositories/survey_repository.dart';
import '../../models/survey.dart';

// Tokens de DESIGN.md: #f7f7f2 (fundo), #e2e7e2, #18583d, #1f2723,
// #68716c, #ffffff, 24 px de margem, rótulo 12 px, botão 56 px/raio 28,
// título 20 px semibold.
//
// O fundo #e2e7e2 do campo, a altura 56 px e o raio 12 px vêm da descrição:
// o DESIGN.md traz #edf1ea/64 px/raio 4 px para o campo de login original.
// O placeholder de 15 px também vem da descrição (DESIGN.md traz 16 px).
//
// #e74c3c para exclusão não existe no DESIGN.md: vem da descrição recebida.
const Color _colorBackground = Color(0xFFF7F7F2);
const Color _colorField = Color(0xFFE2E7E2);
const Color _colorPrimary = Color(0xFF18583D);
const Color _colorText = Color(0xFF1F2723);
const Color _colorSecondary = Color(0xFF68716C);
const Color _colorOnPrimary = Color(0xFFFFFFFF);
const Color _colorDanger = Color(0xFFE74C3C);

/// Formulário de criação e edição de levantamento, 100% local (Drift).
class SurveyFormScreen extends StatefulWidget {
  const SurveyFormScreen({super.key, this.surveyToEdit});

  /// Quando informado, o formulário entra no modo edição.
  final Survey? surveyToEdit;

  @override
  State<SurveyFormScreen> createState() => _SurveyFormScreenState();
}

class _SurveyFormScreenState extends State<SurveyFormScreen> {
  final SurveyRepository _repository = SurveyRepository(appDatabase);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;
  bool _didPop = false;

  bool get _isEditing => widget.surveyToEdit != null;

  @override
  void initState() {
    super.initState();
    final Survey? survey = widget.surveyToEdit;
    if (survey != null) {
      _nameController.text = survey.name;
      _descriptionController.text = survey.description ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final Survey? survey = widget.surveyToEdit;
      if (survey == null) {
        await _repository.createSurvey(
          name: _nameController.text.trim(),
          description: _descriptionController.text,
        );
      } else {
        await _repository.updateSurvey(
          survey.id,
          name: _nameController.text.trim(),
          description: _descriptionController.text,
        );
      }
      if (!mounted) return;
      setState(() => _isLoading = false);
      _didPop = true;
      Navigator.of(context).pop(true);
    } finally {
      if (mounted && !_didPop) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _delete() async {
    final Survey? survey = widget.surveyToEdit;
    if (survey == null) return;

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
            'O levantamento será marcado como excluído e não aparecerá na lista. Os dados locais serão preservados.',
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
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe o nome do levantamento.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.chevron_left,
                        color: _colorPrimary,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  _isEditing ? 'Editar levantamento' : 'Novo levantamento',
                  style: const TextStyle(
                    color: _colorText,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 34 / 20,
                  ),
                ),
                const SizedBox(height: 24),
                _FormTextField(
                  label: 'Nome do levantamento',
                  hint: 'Ex.: Terreno — Piedade',
                  controller: _nameController,
                  validator: _validateName,
                ),
                const SizedBox(height: 16),
                _DescriptionField(controller: _descriptionController),
                const SizedBox(height: 24),
                _PrimaryButton(
                  label: 'Salvar',
                  isLoading: _isLoading,
                  onPressed: _save,
                ),
                if (_isEditing) ...[
                  const SizedBox(height: 12),
                  _DeleteButton(onPressed: _delete),
                ],
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: _colorSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 16 / 12,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: _colorField,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              // ~15 px vem da descrição; DESIGN.md traz 16 px para o campo
              // de acesso original.
              hintStyle: const TextStyle(
                color: _colorSecondary,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            style: const TextStyle(
              color: _colorText,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descrição (opcional)',
          style: TextStyle(
            color: _colorSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 16 / 12,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: _colorField,
            borderRadius: BorderRadius.circular(12),
          ),
          // 3 linhas vêm da descrição. Não há altura fixa de 56 px aqui.
          child: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            style: const TextStyle(
              color: _colorText,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Hover/focus/disabled não definidos no Figma: o Material 3 aplica a
    // opacidade padrão quando onPressed é null durante o carregamento.
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: _colorPrimary,
        foregroundColor: _colorOnPrimary,
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 24 / 16,
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(color: _colorOnPrimary),
            )
          : Text(label),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: _colorDanger,
        side: const BorderSide(color: _colorDanger),
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 24 / 16,
        ),
      ),
      child: const Text('Excluir'),
    );
  }
}
