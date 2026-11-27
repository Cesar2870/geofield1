import 'package:material_ui/material_ui.dart';

import '../../data/app_database.dart';
import '../../data/repositories/survey_repository.dart';

// Tokens de DESIGN.md; valores que só existem no print 6 estão marcados
// no ponto de uso.
const Color _colorBackground = Color(0xFFF7F7F2);
const Color _colorCard = Color(0xFFEDF1EA);
const Color _colorBorder = Color(0xFFE2E7E2);
const Color _colorPrimary = Color(0xFF18583D);
const Color _colorText = Color(0xFF1F2723);
const Color _colorSecondary = Color(0xFF68716C);
const Color _colorOnPrimary = Color(0xFFFFFFFF);

/// Foto simulada. Substituir pelo modelo Drift quando a câmera existir.
class _Photo {
  const _Photo(this.label, this.time);

  final String label;
  final String time;
}

/// Simulação explícita das 3 miniaturas do print 6.
const List<_Photo> _kSimulatedPhotos = [
  _Photo('Foto 1', '14:05'),
  _Photo('Foto 2', '14:12'),
  _Photo('Foto 3', '14:26'),
];

/// Tela "Fotografar" do print 6: sem câmera real e sem persistência.
class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key, this.surveyId});

  /// Id do levantamento ao qual as fotos serão vinculadas.
  final String? surveyId;

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final SurveyRepository _surveyRepository = SurveyRepository(appDatabase);

  // Texto do print 6, mantido quando a tela é aberta sem levantamento vinculado.
  // Com surveyId, o nome real vem do Drift; se não for encontrado, o texto é
  // neutro para não inventar dados.
  String _surveySubtitle = 'Terreno — Piedade';

  @override
  void initState() {
    super.initState();
    _loadSurveyName();
  }

  Future<void> _loadSurveyName() async {
    final String? id = widget.surveyId;
    if (id == null) return;
    final survey = await _surveyRepository.getSurveyById(id);
    if (!mounted || survey == null) return;
    setState(() => _surveySubtitle = survey.name);
  }

  void _showSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Em breve',
          style: TextStyle(
            color: _colorOnPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 20 / 14,
          ),
        ),
        backgroundColor: _colorText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                // 16 px de margem lateral vem do print 6.
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    _PhotoHeader(subtitle: _surveySubtitle),
                    const SizedBox(height: 24),
                    const Text(
                      'Fotografar terreno',
                      style: TextStyle(
                        color: _colorText,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Registre evidências visuais do levantamento.',
                      style: TextStyle(
                        color: _colorSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 20 / 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _PreviewCard(),
                    const SizedBox(height: 24),
                    const Text(
                      'Fotos recentes',
                      style: TextStyle(
                        color: _colorText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _Thumbnails(),
                  ],
                ),
              ),
            ),
            _PhotoFooter(onAction: () => _showSoon(context)),
          ],
        ),
      ),
    );
  }
}

class _PhotoHeader extends StatelessWidget {
  const _PhotoHeader({required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.chevron_left, color: _colorText, size: 24),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fotografar',
                style: TextStyle(
                  color: _colorText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _colorSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      // Proporção e ícone vêm do print 6; DESIGN.md não define placeholder.
      height: 220,
      decoration: BoxDecoration(
        color: _colorCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _colorBorder, width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.photo_camera_outlined, color: _colorSecondary, size: 48),
            SizedBox(height: 12),
            Text(
              'Pré-visualização da foto',
              style: TextStyle(
                color: _colorSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 20 / 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Thumbnails extends StatelessWidget {
  const _Thumbnails();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final _Photo photo in _kSimulatedPhotos) ...[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: _colorCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _colorBorder, width: 1),
                  ),
                  child: const Icon(
                    Icons.image_outlined,
                    color: _colorSecondary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  photo.label,
                  style: const TextStyle(
                    color: _colorText,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  photo.time,
                  style: const TextStyle(
                    color: _colorSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (photo != _kSimulatedPhotos.last) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _PhotoFooter extends StatelessWidget {
  const _PhotoFooter({required this.onAction});

  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(color: _colorBackground),
      child: Column(
        children: [
          // 56 px e raio 28 vêm do print. Hover/focus não definidos; disabled
          // usaria a opacidade padrão do Material 3 se onPressed fosse null.
          FilledButton.icon(
            onPressed: onAction,
            icon: const Icon(Icons.photo_camera, size: 18),
            label: const Text('Tirar foto'),
            style: FilledButton.styleFrom(
              backgroundColor: _colorPrimary,
              foregroundColor: _colorOnPrimary,
              minimumSize: const Size.fromHeight(56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.grid_view, color: _colorPrimary, size: 18),
              label: const Text(
                'Ver todas as fotos',
                style: TextStyle(
                  color: _colorPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: _colorPrimary,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
