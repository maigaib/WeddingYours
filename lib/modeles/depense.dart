// Table depenses
import 'package:cloud_firestore/cloud_firestore.dart';

class Depense {
  String? depenseId;
  String description;
  double depenseMontant;
  String budgetId;

  Depense({
    required this.depenseId,
    required this.description,
    required this.depenseMontant,
    required this.budgetId,
  });

  factory Depense.fromMap(Map<String, dynamic> map, DocumentReference docRef) {
    return Depense(
      depenseId: docRef.id,
      description: map['description'],
      depenseMontant: map['depenseMontant'],
      budgetId: map['budgetId'],
    );
  }

  Map<String, dynamic> toMap() {

    return{
      'description' : description,
      'depensesMontant' : depenseMontant,
      'budgetId' : budgetId
    };

  }
}