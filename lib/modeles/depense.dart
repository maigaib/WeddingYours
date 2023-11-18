// Table depenses
class Depense {
  int depenseId;
  String libelle;
  double depenseMontant;
  int budgetId;

  Depense({
    required this.depenseId,
    required this.libelle,
    required this.depenseMontant,
    required this.budgetId,
  });

  factory Depense.fromMap(Map<String, dynamic> map) {
    return Depense(
      depenseId: map['depenseId'],
      libelle: map['libelle'],
      depenseMontant: map['depenseMontant'],
      budgetId: map['budgetId'],
    );
  }
}