import 'package:material_ui/material_ui.dart';

import 'home/home_screen.dart';
import 'profile/profile_screen.dart';
import 'surveys/surveys_screen.dart';

// Tokens extraídos de DESIGN.md.
const Color _colorNavBackground = Color(0xFFF7F7F2);
const Color _colorNavBorder = Color(0xFFE2E7E2);
const Color _colorActive = Color(0xFF18583D);
const Color _colorInactive = Color(0xFF68716C);

/// Casca de navegação do app autenticado: Início, Levantamentos e Perfil.
class MainShell extends StatefulWidget {
  const MainShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabTap(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorNavBackground,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(onOpenSurveysTap: () => _onTabTap(1)),
          const SurveysScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: _colorNavBackground,
          border: Border(
            top: BorderSide(color: _colorNavBorder, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: _colorNavBackground,
          selectedItemColor: _colorActive,
          unselectedItemColor: _colorInactive,
          iconSize: 22,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 16 / 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 16 / 12,
          ),
          // DESIGN.md não registra sombras nos frames consultados.
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Levantamentos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
