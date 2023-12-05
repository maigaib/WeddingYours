import 'package:app_wedding_yours/modeles/budget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BudgetService {
  final CollectionReference budgetsCollection =
      FirebaseFirestore.instance.collection('budgets');

   Future<Budget?> getBudgetByMariageId(String mariageId) async {
    try {
      // Utilisez une requête Firestore pour obtenir le budget par mariageId
      final querySnapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .where('mariageId', isEqualTo: mariageId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Si des documents sont trouvés, renvoyer le premier budget
        final budgetDoc = querySnapshot.docs.first; // Définissez la variable `budgetDoc`
      return Budget.fromMap(budgetDoc.data() as Map<String, dynamic>, budgetDoc.reference);
      } else {
        // Si aucun document n'est trouvé, renvoyer null
        return null;
      }
    } catch (e) {
      // Gérer les erreurs ici (journalisation, etc.)
      print('Erreur lors de la récupération du budget par mariageId: $e');
      return null;
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getBudgetParMariageId(String mariageId) async {
    return await _firestore.collection('budgets').doc(mariageId).get();
  }

 // Method to update a budget
 Future<void> update(Budget budget) async {
    try {
      // Utilisez Firestore pour mettre à jour la tâche
      await FirebaseFirestore.instance
          .collection('budgets')
          .doc(budget.budgetId)
          .update(budget.toMap()); 
    } catch (e) {
      print('Erreur lors de la mise à jour de la tâche: $e');
      throw e;
    }
  }


}