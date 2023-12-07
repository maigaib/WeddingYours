import 'dart:async';

import 'package:app_wedding_yours/modeles/depense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class DepenseService {
//   final StreamController<List<Depense>> _depensesController =
//       StreamController<List<Depense>>.broadcast();

//   Stream<List<Depense>> get depensesStream => _depensesController.stream;

//   Future<void> create(Depense depense) async {
//   final docRef = await FirebaseFirestore.instance.collection('depenses').add(depense.toMap());
//   depense.depenseId = docRef.id;

//   // Diffusez la nouvelle liste de tâches après l'ajout d'une nouvelle tâche
//   _depensesController.add(await getDepenses());
// }


//   Future<void> update(Depense depense) async {
//     try {
//       // Utilisez Firestore pour mettre à jour la dépense
//       await FirebaseFirestore.instance
//           .collection('depenses')
//           .doc(depense.depenseId)
//           .update(depense.toMap());
//     } catch (e) {
//       print('Erreur lors de la mise à jour de la dépense: $e');
//       throw e;
//     }
//   }

//   Future<void> delete(String depenseId) async {
//     try {
//       await FirebaseFirestore.instance.collection('depenses').doc(depenseId).delete();
//       // Diffusez la nouvelle liste de dépenses après la suppression d'une dépense
//       _depensesController.add(await getDepenses());
//     } catch (e) {
//       print('Erreur lors de la suppression de la dépense: $e');
//       throw e;
//     }
//   }

//  Future<List<Depense>> getDepenses() async {
//   try {
//     QuerySnapshot<Map<String, dynamic>> depenseSnapshot =
//         await FirebaseFirestore.instance.collection('depenses').get();

//     // Check if there are any documents
//     if (depenseSnapshot.docs.isEmpty) {
//       print('No expenses found.');
//       return [];
//     }

//     return depenseSnapshot.docs.map((doc) {
//       return Depense.fromMap(doc.data() as Map<String, dynamic>, doc.reference);
//     }).toList();
//   } catch (e) {
//     print('Error fetching expenses: $e');
//     return [];
//   }
// }



// }

//============================================ new stream =====================
class DepenseService {
  final StreamController<List<Depense>> _depensesController = StreamController<List<Depense>>.broadcast();
  Stream<List<Depense>> get depensesStream => _depensesController.stream;

  // Méthode pour récupérer la liste des dépenses
  // Future<void> fetchDepensesList() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> depenseSnapshot = await FirebaseFirestore.instance.collection('depenses').get();

  //     List<Depense> depensesList = depenseSnapshot.docs.map((doc) {
  //       return Depense.fromMap(doc.data() as Map<String, dynamic>, doc.reference);
  //     }).toList();

  //     _depensesController.add(depensesList);
  //   } catch (e) {
  //     print('Erreur lors de la récupération des dépenses: $e');
  //     _depensesController.addError(e);
  //   }
  // }
      Future<void> fetchDepensesList(String budgetId) async {
        try {
          QuerySnapshot<Map<String, dynamic>> depenseSnapshot = await FirebaseFirestore.instance
              .collection('depenses')
              .where('budgetId', isEqualTo: budgetId)
              .get();

          List<Depense> depensesList = depenseSnapshot.docs.map((doc) {
            return Depense.fromMap(doc.data() as Map<String, dynamic>, doc.reference);
          }).toList();

          _depensesController.add(depensesList);
        } catch (e) {
          print('Erreur lors de la récupération des dépenses: $e');
          _depensesController.addError(e);
        }
      }


  // Méthode pour créer une dépense
  Future<void> createDepense(Depense depense, String budgetId) async {
    try {
      final docRef = await FirebaseFirestore.instance.collection('depenses').add(depense.toMap());
      depense.depenseId = docRef.id;

      // Émettre les mises à jour de la liste
      await fetchDepensesList(budgetId);
    } catch (e) {
      print('Erreur lors de la création de la dépense: $e');
    }
  }

  // Méthode pour supprimer une dépense
  Future<void> deleteDepense(String depenseId, String budgetId) async {
    try {
      await FirebaseFirestore.instance.collection('depenses').doc(depenseId).delete();

      // Émettre les mises à jour de la liste
      await fetchDepensesList(budgetId);
    } catch (e) {
      print('Erreur lors de la suppression de la dépense: $e');
    }
  }

  // Méthode pour mettre à jour une dépense
  Future<void> updateDepense(Depense depense, String budgetId) async {
    try {
      await FirebaseFirestore.instance
          .collection('depenses')
          .doc(depense.depenseId)
          .update(depense.toMap());

      // Émettre les mises à jour de la liste
      await fetchDepensesList(budgetId);
    } catch (e) {
      print('Erreur lors de la mise à jour de la dépense: $e');
    }
  }

  Future<void> fetchDepensesBybudgetId(String budgetId) async {
  try {
    QuerySnapshot<Map<String, dynamic>> depenseSnapshot = await FirebaseFirestore.instance
        .collection('depenses')
        .where('budgetId', isEqualTo: budgetId)
        .get();

    List<Depense> depensesList = depenseSnapshot.docs.map((doc) {
      return Depense.fromMap(doc.data() as Map<String, dynamic>, doc.reference);
    }).toList();

    _depensesController.add(depensesList);
  } catch (e) {
    print('Erreur lors de la récupération des dépenses par mariage: $e');
    _depensesController.addError(e);
  }
}

  // Fermer le StreamController lorsqu'il n'est plus utilisé
  void dispose() {
    _depensesController.close();
  }
}
