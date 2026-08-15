import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'surveys_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();

  // Permet à n'importe quel écran enfant de faire :
  // MainNavigation.of(context)?.goToTab(1) pour changer d'onglet
  static _MainNavigationState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MainNavigationState>();
  }
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SurveysScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  void goToTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: goToTab,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textGrey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: "Sondages"),
          BottomNavigationBarItem(icon: Icon(Icons.wallet_outlined), label: "Portefeuille"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profil"),
        ],
      ),
    );
  }
}
