import 'package:app_wedding_yours/modeles/mariage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MariagesRepository {
  final CollectionReference mariagesCollection =
      FirebaseFirestore.instance.collection('mariages');
//ajout mariage
  Future<void> addMariage(Mariage mariage) async {
    await mariagesCollection.add(mariage.toMap());
  }
//modifier mariage
  Future<void> updateMariage(Mariage mariage) async {
    try {
    await mariagesCollection.doc(mariage.mariageId.toString()).update(mariage.toMap());
      
    } catch (e) {
      print('Erreur Firebase: $e');
    }

  }
//supprimer 
  Future<void> deleteMariage(String mariageId) async {
    await mariagesCollection.doc(mariageId.toString()).delete();
  }
//liste des mariages 
  Future<List<Mariage>> getMariages() async {
    QuerySnapshot querySnapshot = await mariagesCollection.get();
    return querySnapshot.docs
        .map((doc) => Mariage.fromMap(doc.data() as Map<String, dynamic>, doc.reference))
        .toList();
  }
//un mariage specifique
  // Future<Mariage> getMariageById(String mariageId) async {
  //   DocumentSnapshot docSnapshot = await mariagesCollection.doc(mariageId.toString()).get();
  //   return Mariage.fromMap(docSnapshot.data() as Map<String, dynamic>);
  // }

  Future<Mariage> getMariageById(String mariageId) async {
      DocumentSnapshot docSnapshot = await mariagesCollection.doc(mariageId.toString()).get();
      return Mariage.fromMap(docSnapshot.data() as Map<String, dynamic>, docSnapshot.reference);
    }
}
