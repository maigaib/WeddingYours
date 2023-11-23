import 'dart:async';

import 'package:app_wedding_yours/modeles/depense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepenseService {
  final StreamController<List<Depense>> _depensesController =
      StreamController<List<Depense>>.broadcast();

  Stream<List<Depense>> get depensesStream => _depensesController.stream;

  Future<void> create(Depense depense) async {
    final docRef =
        await FirebaseFirestore.instance.collection('depenses').add(depense.toMap());
    depense.depenseId = docRef.id;

    // Diffusez la nouvelle liste de tâches après l'ajout d'une nouvelle tâche
    _depensesController.add(await getDepenses());
  }

   Future<void> update(Depense depense) async {
    try {
      // Utilisez Firestore pour mettre à jour la tâche
      await FirebaseFirestore.instance
          .collection('depenses')
          .doc(depense.depenseId)
          .update(depense.toMap()); 
    } catch (e) {
      print('Erreur lors de la mise à jour de la tâche: $e');
      throw e;
    }
  }

  Future<void> delete(String depenseId) async {
  try {
    await FirebaseFirestore.instance.collection('depenses').doc(depenseId).delete();
  } catch (e) {
    print('Erreur lors de la suppression de la tâche: $e');
  }
}

Future<List<Depense>> getDepenses() async {
  try {
    QuerySnapshot<Map<String, dynamic>> depenseSnapshot =
        await FirebaseFirestore.instance.collection('depenses').get();

    return depenseSnapshot.docs.map((doc) {
      return Depense.fromMap(
          doc.data() as Map<String, dynamic>, doc.reference);
    }).toList();
  } catch (e) {
    print('Erreur lors de la récupération des dépenses: $e');
    return [];
  }
}

}