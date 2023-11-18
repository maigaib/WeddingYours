// Table budget
class Budget {
  int budgetId;
  double budgetMontant;
  int mariageId;

  Budget({
    required this.budgetId,
    required this.budgetMontant,
    required this.mariageId,
  });

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      budgetId: map['budgetId'],
      budgetMontant: map['budgetMontant'],
      mariageId: map['mariageId'],
    );
  }
}