import 'dart:async';

import 'package:app_wedding_yours/modeles/depense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepenseService {
  final StreamController<List<Depense>> _depensesController =
      StreamController<List<Depense>>.broadcast();

  Stream<List<Depense>> get depensesStream => _depensesController.stream;

  Future<void> create(Depense depense) async {
  final docRef = await FirebaseFirestore.instance.collection('depenses').add(depense.toMap());
  depense.depenseId = docRef.id;

  // Diffusez la nouvelle liste de tâches après l'ajout d'une nouvelle tâche
  _depensesController.add(await getDepenses());
}


  Future<void> update(Depense depense) async {
    try {
      // Utilisez Firestore pour mettre à jour la dépense
      await FirebaseFirestore.instance
          .collection('depenses')
          .doc(depense.depenseId)
          .update(depense.toMap());
    } catch (e) {
      print('Erreur lors de la mise à jour de la dépense: $e');
      throw e;
    }
  }

  Future<void> delete(String depenseId) async {
    try {
      await FirebaseFirestore.instance.collection('depenses').doc(depenseId).delete();
      // Diffusez la nouvelle liste de dépenses après la suppression d'une dépense
      _depensesController.add(await getDepenses());
    } catch (e) {
      print('Erreur lors de la suppression de la dépense: $e');
      throw e;
    }
  }

 Future<List<Depense>> getDepenses() async {
  try {
    QuerySnapshot<Map<String, dynamic>> depenseSnapshot =
        await FirebaseFirestore.instance.collection('depenses').get();

    // Check if there are any documents
    if (depenseSnapshot.docs.isEmpty) {
      print('No expenses found.');
      return [];
    }

    return depenseSnapshot.docs.map((doc) {
      return Depense.fromMap(doc.data() as Map<String, dynamic>, doc.reference);
    }).toList();
  } catch (e) {
    print('Error fetching expenses: $e');
    return [];
  }
}



}
