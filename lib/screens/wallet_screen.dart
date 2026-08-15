import 'package:flutter/material.dart';
import 'home_screen.dart'; // pour AppColors

// Liste des pays et leurs opérateurs mobile money (Afrique de l'Ouest francophone)
class CountryPayment {
  final String country;
  final String flag;
  final List<String> operators;

  const CountryPayment({
    required this.country,
    required this.flag,
    required this.operators,
  });
}

const List<CountryPayment> supportedCountries = [
  CountryPayment(country: "Bénin", flag: "🇧🇯", operators: ["MTN MoMo", "Moov Money"]),
  CountryPayment(country: "Côte d'Ivoire", flag: "🇨🇮", operators: ["MTN MoMo", "Orange Money", "Moov Money", "Wave"]),
  CountryPayment(country: "Sénégal", flag: "🇸🇳", operators: ["Orange Money", "Free Money", "Wave"]),
  CountryPayment(country: "Togo", flag: "🇹🇬", operators: ["Togocel T-Money", "Moov Flooz"]),
  CountryPayment(country: "Mali", flag: "🇲🇱", operators: ["Orange Money", "Moov Money"]),
  CountryPayment(country: "Burkina Faso", flag: "🇧🇫", operators: ["Orange Money", "Moov Money"]),
  CountryPayment(country: "Niger", flag: "🇳🇪", operators: ["Airtel Money", "Orange Money"]),
  CountryPayment(country: "Guinée", flag: "🇬🇳", operators: ["Orange Money", "MTN MoMo"]),
];

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Données factices en attendant la connexion à la base de données
    const double balance = 12500;
    const String currency = "FCFA";

    final transactions = [
      {"title": "Sondage complété", "amount": "+250 FCFA", "date": "Aujourd'hui, 14:20", "positive": true},
      {"title": "Retrait MTN MoMo", "amount": "-5000 FCFA", "date": "Hier, 09:10", "positive": false},
      {"title": "Sondage complété", "amount": "+150 FCFA", "date": "12 août, 18:45", "positive": true},
      {"title": "Retrait Moov Money", "amount": "-2000 FCFA", "date": "8 août, 16:02", "positive": false},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text("Portefeuille", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBalanceCard(context, balance, currency),
          const SizedBox(height: 24),
          const Text(
            "Historique des transactions",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
          const SizedBox(height: 12),
          ...transactions.map((t) => _buildTransactionTile(t)),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, double balance, String currency) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Solde disponible", style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 6),
          Text(
            "${balance.toStringAsFixed(0)} $currency",
            style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showWithdrawSheet(context, balance, currency),
              icon: const Icon(Icons.arrow_upward, size: 18),
              label: const Text("Retirer mes gains"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.textDark,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(Map<String, Object> t) {
    final bool positive = t["positive"] as bool;
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (positive ? AppColors.primary : Colors.redAccent).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  positive ? Icons.arrow_downward : Icons.arrow_upward,
                  color: positive ? AppColors.primary : Colors.redAccent,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t["title"] as String,
                      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
                  const SizedBox(height: 3),
                  Text(t["date"] as String,
                      style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
                ],
              ),
            ],
          ),
          Text(
            t["amount"] as String,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: positive ? AppColors.primary : Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  // Ouvre le formulaire de retrait en bas de l'écran
  void _showWithdrawSheet(BuildContext context, double balance, String currency) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WithdrawSheet(balance: balance, currency: currency),
    );
  }
}

// Formulaire de retrait : choix pays -> choix opérateur -> numéro -> montant
class _WithdrawSheet extends StatefulWidget {
  final double balance;
  final String currency;

  const _WithdrawSheet({required this.balance, required this.currency});

  @override
  State<_WithdrawSheet> createState() => _WithdrawSheetState();
}

class _WithdrawSheetState extends State<_WithdrawSheet> {
  CountryPayment? _selectedCountry;
  String? _selectedOperator;
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Retirer mes gains",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            const SizedBox(height: 4),
            Text(
              "Solde disponible : ${widget.balance.toStringAsFixed(0)} ${widget.currency}",
              style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Choix du pays
            const Text("Pays", style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 8),
            DropdownButtonFormField<CountryPayment>(
              initialValue: _selectedCountry,
              decoration: _inputDecoration("Sélectionne ton pays"),
              items: supportedCountries.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Text("${c.flag}  ${c.country}"),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                  _selectedOperator = null; // reset l'opérateur si le pays change
                });
              },
            ),
            const SizedBox(height: 16),

            // Choix de l'opérateur (dépend du pays sélectionné)
            if (_selectedCountry != null) ...[
              const Text("Opérateur mobile money",
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _selectedCountry!.operators.map((op) {
                  final bool selected = _selectedOperator == op;
                  return ChoiceChip(
                    label: Text(op),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedOperator = op),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(color: selected ? Colors.white : AppColors.textDark),
                    backgroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: selected ? AppColors.primary : Colors.grey.shade300),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],

            // Numéro de téléphone
            const Text("Numéro de téléphone", style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration("Ex: 97 00 00 00"),
            ),
            const SizedBox(height: 16),

            // Montant à retirer
            const Text("Montant à retirer", style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration("Ex: 5000").copyWith(suffixText: widget.currency),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_selectedCountry != null && _selectedOperator != null)
                    ? () {
                        // TODO: envoyer la demande de retrait au serveur
                        Navigator.pop(context);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.textGrey.withOpacity(0.3),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text("Confirmer le retrait", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
