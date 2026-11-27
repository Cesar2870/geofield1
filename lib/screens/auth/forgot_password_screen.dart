import 'package:material_ui/material_ui.dart';

import '../../services/auth_service.dart';

// Tokens de DESIGN.md: #f7f7f2 (fundo), #1f2723 (texto primário),
// #68716c (texto secundário), #ffffff, #e2e7e2 e #18583d (verde de destaque,
// presente no arquivo nas seções de Proposta 2/mapa e já usado na LoginScreen).
//
// O DESIGN.md descreve o campo de acesso do login original como #edf1ea,
// 64 px de altura e raio 4 px nos cantos superiores. A descrição recebida para
// Recuperação pede o mesmo estilo da LoginScreen: #e2e7e2, 56 px e raio 12 px.
// Esses valores vêm da descrição. A cor #18583d do botão e dos links também
// vem da descrição destas telas (o DESIGN.md traz #234b3a para o login original).
const Color _colorBackground = Color(0xFFF7F7F2);
const Color _colorField = Color(0xFFE2E7E2);
const Color _colorPrimary = Color(0xFF18583D);
const Color _colorTextPrimary = Color(0xFF1F2723);
const Color _colorTextSecondary = Color(0xFF68716C);
const Color _colorOnPrimary = Color(0xFFFFFFFF);

/// Tela de recuperação de senha.
///
/// A navegação é injetada por quem montar a tela. No AuthGate, o retorno
/// padrão é `Navigator.pop()`, voltando para a LoginScreen.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
    required this.authService,
    this.onBackTap,
  });

  final AuthService authService;
  final VoidCallback? onBackTap;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _goBack() {
    final VoidCallback? onBackTap = widget.onBackTap;
    if (onBackTap != null) {
      onBackTap();
      return;
    }
    Navigator.of(context).pop();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await widget.authService.resetPasswordForEmail(
        email: _emailController.text.trim(),
      );
      if (!mounted) return;
      _emailController.clear();
      _showMessage(
        'Se este e-mail estiver cadastrado, você receberá um link de recuperação.',
      );
    } on AuthFailure catch (error) {
      if (!mounted) return;
      _showMessage(error.message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: _colorOnPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 20 / 14,
          ),
        ),
        backgroundColor: _colorTextPrimary,
      ),
    );
  }

  String? _validateEmail(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) return 'Informe seu e-mail.';
    final RegExp emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailPattern.hasMatch(text)) return 'Informe um e-mail válido.';
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
                  child: _AuthBackButton(onPressed: _goBack),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Recuperar senha',
                  style: TextStyle(
                    color: _colorTextPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    height: 36 / 28,
                  ),
                ),
                const SizedBox(height: 8),
                // ~15 px e line-height 1.4 vêm da descrição; DESIGN.md traz
                // 14 px para o subtítulo da tela de login original.
                const Text(
                  'Informe seu e-mail e enviaremos um link para redefinir sua senha.',
                  style: TextStyle(
                    color: _colorTextSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                _AuthTextField(
                  label: 'E-mail',
                  hint: 'seuemail@exemplo.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 24),
                _AuthPrimaryButton(
                  label: 'Enviar link de recuperação',
                  isLoading: _isLoading,
                  onPressed: _submit,
                ),
                const SizedBox(height: 16),
                _AuthCenteredLink(label: 'Voltar para o login', onPressed: _goBack),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthBackButton extends StatelessWidget {
  const _AuthBackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.chevron_left, color: _colorPrimary, size: 24),
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: _colorTextSecondary,
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
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              // ~15 px vem da descrição; DESIGN.md traz 16 px para o valor do
              // campo de acesso original.
              hintStyle: const TextStyle(
                color: _colorTextSecondary,
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
              color: _colorTextPrimary,
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

class _AuthPrimaryButton extends StatelessWidget {
  const _AuthPrimaryButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Hover/focus/disabled não definidos no Figma: com isLoading o botão fica
    // sem onPressed e o Material 3 aplica a opacidade padrão do tema.
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

class _AuthCenteredLink extends StatelessWidget {
  const _AuthCenteredLink({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          minimumSize: const Size(0, 48),
        ),
        // 14 px semibold vem do link de botão em DESIGN.md; a cor #18583D
        // vem da descrição desta tela.
        child: Text(
          label,
          style: const TextStyle(
            color: _colorPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 20 / 14,
          ),
        ),
      ),
    );
  }
}
