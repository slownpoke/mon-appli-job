import 'package:flutter/material.dart';
import 'home_screen.dart'; // pour AppColors

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Données factices en attendant la connexion à la base de données
    const String userName = "Mike";
    const String userPhone = "01 97 00 00 00";
    const String userCountry = "🇧🇯 Bénin";

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(userName, userPhone, userCountry),
          const SizedBox(height: 20),
          _buildSectionTitle("Compte"),
          _buildMenuTile(Icons.person_outline, "Modifier mon profil"),
          _buildMenuTile(Icons.lock_outline, "Sécurité et mot de passe"),
          _buildMenuTile(Icons.public, "Changer de pays"),
          const SizedBox(height: 12),
          _buildSectionTitle("Préférences"),
          _buildMenuTile(Icons.language, "Langue", trailing: "Français"),
          _buildMenuTile(Icons.notifications_outlined, "Notifications"),
          const SizedBox(height: 12),
          _buildSectionTitle("Aide"),
          _buildMenuTile(Icons.headset_mic_outlined, "Contacter le support"),
          _buildMenuTile(Icons.description_outlined, "Conditions d'utilisation"),
          _buildMenuTile(Icons.info_outline, "À propos de l'application"),
          const SizedBox(height: 20),
          _buildLogoutButton(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // En-tête avec avatar, nom, téléphone et pays
  Widget _buildHeader(String name, String phone, String country) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white.withOpacity(0.15),
            child: const Icon(Icons.person, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 14),
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            phone,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            country,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.textGrey,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String title, {String? trailing}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: 22),
        title: Text(title, style: const TextStyle(color: AppColors.textDark, fontSize: 14)),
        trailing: trailing != null
            ? Text(trailing, style: const TextStyle(color: AppColors.textGrey, fontSize: 13))
            : const Icon(Icons.chevron_right, color: AppColors.textGrey, size: 20),
        onTap: () {
          // TODO: naviguer vers l'écran correspondant
        },
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () {
            // TODO: gérer la déconnexion
          },
          icon: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
          label: const Text("Se déconnecter", style: TextStyle(color: Colors.redAccent)),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            side: const BorderSide(color: Colors.redAccent),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
