import 'package:flutter/material.dart';
import 'main_navigation.dart';

// Palette de couleurs de l'application
class AppColors {
  static const primary = Color(0xFF0F6B5C); // Vert émeraude foncé
  static const primaryLight = Color(0xFF14A085);
  static const accent = Color(0xFFE8B84B); // Doré (gains)
  static const background = Color(0xFFF5F7F6);
  static const cardWhite = Colors.white;
  static const textDark = Color(0xFF1A2E2A);
  static const textGrey = Color(0xFF6B7876);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Données factices en attendant la connexion à la base de données
    const String userName = "Mike";
    const double balance = 12500;
    const String currency = "FCFA";

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(userName),
              _buildBalanceCard(balance, currency),
              _buildQuickActions(context),
              _buildRecentActivity(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // En-tête avec salutation et icône profil
  Widget _buildHeader(String userName) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bonjour 👋",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white.withOpacity(0.15),
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Carte du solde, positionnée à cheval sur l'en-tête
  Widget _buildBalanceCard(double balance, String currency) {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Solde disponible",
                style: TextStyle(color: AppColors.textGrey, fontSize: 13),
              ),
              const SizedBox(height: 6),
              Text(
                "${balance.toStringAsFixed(0)} $currency",
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: naviguer vers l'écran de retrait
                  },
                  icon: const Icon(Icons.account_balance_wallet_outlined,
                      size: 18),
                  label: const Text("Retirer mes gains"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.textDark,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Grille d'actions rapides
  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {"icon": Icons.assignment_outlined, "label": "Sondages", "tabIndex": 1},
      {"icon": Icons.sports_esports_outlined, "label": "Jeux", "tabIndex": null},
      {"icon": Icons.receipt_long_outlined, "label": "Historique", "tabIndex": null},
      {"icon": Icons.headset_mic_outlined, "label": "Support", "tabIndex": null},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions.map((action) {
          return GestureDetector(
            onTap: () {
              final tabIndex = action["tabIndex"] as int?;
              if (tabIndex != null) {
                MainNavigation.of(context)?.goToTab(tabIndex);
              }
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(action["icon"] as IconData,
                      color: AppColors.primary, size: 24),
                ),
                const SizedBox(height: 6),
                Text(
                  action["label"] as String,
                  style: const TextStyle(fontSize: 12, color: AppColors.textDark),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Liste d'activité récente (factice)
  Widget _buildRecentActivity() {
    final activities = [
      {"title": "Sondage complété", "amount": "+250 FCFA", "time": "Aujourd'hui, 14:20"},
      {"title": "Retrait MTN MoMo", "amount": "-5000 FCFA", "time": "Hier, 09:10"},
      {"title": "Sondage complété", "amount": "+150 FCFA", "time": "12 août, 18:45"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Activité récente",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          ...activities.map((a) {
            final isPositive = (a["amount"] as String).startsWith("+");
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a["title"] as String,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark)),
                      const SizedBox(height: 3),
                      Text(a["time"] as String,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textGrey)),
                    ],
                  ),
                  Text(
                    a["amount"] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isPositive ? AppColors.primary : Colors.redAccent,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

}
