import 'package:material_ui/material_ui.dart';

const Color _colorBackground = Color(0xFFF7F7F2);
const Color _colorText = Color(0xFF1F2723);
const Color _colorSecondary = Color(0xFF68716C);

/// Placeholder da aba Levantamentos; conteúdo real nas etapas seguintes.
class SurveysScreen extends StatelessWidget {
  const SurveysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: _colorBackground,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Levantamentos',
                style: TextStyle(
                  color: _colorText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 34 / 20,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Em preparação.',
                style: TextStyle(
                  color: _colorSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
