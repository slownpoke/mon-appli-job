import 'package:flutter/material.dart';
import 'home_screen.dart'; // pour AppColors

// Modèle simple pour un sondage (sera remplacé par les données de la BDD)
class Survey {
  final String title;
  final String category;
  final int reward; // en FCFA
  final int durationMinutes;
  final int questionsCount;
  final bool isCompleted;

  Survey({
    required this.title,
    required this.category,
    required this.reward,
    required this.durationMinutes,
    required this.questionsCount,
    this.isCompleted = false,
  });
}

class SurveysScreen extends StatelessWidget {
  const SurveysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Données factices en attendant la connexion à la base de données
    final surveys = [
      Survey(
        title: "Habitudes de consommation mobile",
        category: "Télécom",
        reward: 250,
        durationMinutes: 5,
        questionsCount: 8,
      ),
      Survey(
        title: "Votre avis sur les réseaux sociaux",
        category: "Digital",
        reward: 180,
        durationMinutes: 3,
        questionsCount: 6,
      ),
      Survey(
        title: "Expérience d'achat en ligne",
        category: "E-commerce",
        reward: 400,
        durationMinutes: 8,
        questionsCount: 12,
      ),
      Survey(
        title: "Alimentation et santé",
        category: "Santé",
        reward: 150,
        durationMinutes: 4,
        questionsCount: 7,
        isCompleted: true,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          "Sondages disponibles",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoBanner(surveys.length),
          const SizedBox(height: 16),
          ...surveys.map((s) => _buildSurveyCard(context, s)),
        ],
      ),
    );
  }

  // Bandeau d'information en haut
  Widget _buildInfoBanner(int count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$count sondages disponibles. Réponds honnêtement pour gagner tes récompenses.",
              style: const TextStyle(fontSize: 13, color: AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }

  // Carte pour un sondage
  Widget _buildSurveyCard(BuildContext context, Survey survey) {
    return Opacity(
      opacity: survey.isCompleted ? 0.55 : 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    survey.category,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (survey.isCompleted)
                  const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              survey.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildMetaChip(Icons.timer_outlined, "${survey.durationMinutes} min"),
                const SizedBox(width: 10),
                _buildMetaChip(Icons.help_outline, "${survey.questionsCount} questions"),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "+${survey.reward} FCFA",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.accent,
                  ),
                ),
                ElevatedButton(
                  onPressed: survey.isCompleted
                      ? null
                      : () {
                          // TODO: naviguer vers l'écran du sondage
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.textGrey.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(survey.isCompleted ? "Terminé" : "Commencer"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textGrey),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
      ],
    );
  }
}
