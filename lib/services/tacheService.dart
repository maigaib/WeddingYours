import 'dart:async';

import 'package:app_wedding_yours/modeles/tache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TacheService {
  final StreamController<List<Tache>> _tasksController =
      StreamController<List<Tache>>.broadcast();

  Stream<List<Tache>> get tasksStream => _tasksController.stream;

  Future<void> create(Tache tache) async {
    final docRef =
        await FirebaseFirestore.instance.collection('taches').add(tache.toMap());
    tache.tacheId = docRef.id;

    // Diffusez la nouvelle liste de tâches après l'ajout d'une nouvelle tâche
    _tasksController.add(await getTasks());
  }

   Future<void> update(Tache tache) async {
    try {
      // Utilisez Firestore pour mettre à jour la tâche
      await FirebaseFirestore.instance
          .collection('taches')
          .doc(tache.tacheId)
          .update(tache.toMap()); 
    } catch (e) {
      print('Erreur lors de la mise à jour de la tâche: $e');
      throw e;
    }
  }

  Future<void> delete(String tacheId) async {
  try {
    await FirebaseFirestore.instance.collection('taches').doc(tacheId).delete();
  } catch (e) {
    print('Erreur lors de la suppression de la tâche: $e');
  }
}
  Future<List<Tache>> getTasks() async {
    try {
      QuerySnapshot<Map<String, dynamic>> taskSnapshot =
          await FirebaseFirestore.instance.collection('taches').get();

      return taskSnapshot.docs.map((doc) {
        return Tache.fromMap(
            doc.data() as Map<String, dynamic>, doc.reference);
      }).toList();
    } catch (e) {
      print('Erreur lors de la récupération des tâches: $e');
      return [];
    }
  }


  /// ============================list default 
  Future<List<Tache>> getTasksList() async {
    try {
      // Utilisation de Firestore pour récupérer les tâches
      QuerySnapshot<Map<String, dynamic>> taskSnapshot = await FirebaseFirestore.instance.collection('taches').get();

      //Convertir les documents Firestore en une liste de tâches
      List<Tache> tasksList = taskSnapshot.docs.map((doc) {
            return Tache.fromMap(
              doc.data() as Map<String, dynamic>, doc.reference
            );
          }).toList();

      return tasksList;
    } catch (e) {
      print('Erreur lors de la récupération des tâches: $e');
      return [];
    }
  }


  // Ajoutez cette méthode si nécessaire pour fermer le stream
  void dispose() {
    _tasksController.close();
  }
}
