import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_wedding_yours/modeles/utilisateurs.dart';

class UtilisateursRepository extends ChangeNotifier {
  // Attributs
  List<Utilisateurs> _utilisateurs = [];

  // Méthodes
  Future<void> getUtilisateurs() async {
    // Récupération des utilisateurs
    List<Map<String, dynamic>> utilisateursMap = await FirebaseFirestore.instance
        .collection('utilisateurs')
        .get()
        .then((querySnapshot) => querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());

    // Conversion des utilisateurs en objets `Utilisateurs`
    _utilisateurs = utilisateursMap.map((utilisateurMap) => Utilisateurs.fromMap(utilisateurMap)).toList();

    // Mise à jour des widgets
    notifyListeners();
  }

  Future<void> addUtilisateur(Utilisateurs utilisateur) async {
    // Ajout de l'utilisateur
    await FirebaseFirestore.instance
        .collection('utilisateurs')
        .doc(utilisateur.id)
        .set(utilisateur.toMap());

    // Mise à jour des utilisateurs
    await getUtilisateurs();
  }

  Future<void> updateUtilisateur(Utilisateurs utilisateur) async {
    // Mise à jour de l'utilisateur
    await FirebaseFirestore.instance
        .collection('utilisateurs')
        .doc(utilisateur.id)
        .update(utilisateur.toMap());

    // Mise à jour des utilisateurs
    await getUtilisateurs();
  }

  Future<void> deleteUtilisateur(String utilisateurId) async {
    // Suppression de l'utilisateur
    await FirebaseFirestore.instance
        .collection('utilisateurs')
        .doc(utilisateurId)
        .delete();

    // Mise à jour des utilisateurs
    await getUtilisateurs();
  }

  Utilisateurs? getUtilisateurById(String utilisateurId) {
  // Recherche de l'utilisateur par ID
  Utilisateurs? utilisateur;

  try {
    utilisateur = _utilisateurs.firstWhere((user) => user.id == utilisateurId);
  } catch (e) {
    utilisateur = null;
  }

  return utilisateur;
}


  // Autres méthodes...
}
