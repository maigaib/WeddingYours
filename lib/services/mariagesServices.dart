
import 'dart:io';

import 'package:app_wedding_yours/modeles/mariage.dart';
import 'package:app_wedding_yours/repositories/mariagesRepository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MariagesService {
  final MariagesRepository _repository = MariagesRepository();

  Future<void> addMariage(Mariage mariage) async {
    await _repository.addMariage(mariage);
    
  }

  Future<void> updateMariage(Mariage mariage) async {
    await _repository.updateMariage(mariage);
  }

  Future<void> deleteMariage(String mariageId) async {
    await _repository.deleteMariage(mariageId);
  }

  // Future<List<Mariage>> getMariages() async {
  //   return await _repository.getMariages();
  // }

  // Future<Mariage> getMariageById(String mariageId) async {
  //   return await _repository.getMariageById(mariageId);
  // }

  Future<Mariage> getMariageById(String mariageId) async {
    return await _repository.getMariageById(mariageId);
  }

  Future<Map<String, String>> uploadWeddingImage(File image) async {
     final ref = FirebaseStorage.instance
       .ref()
       .child('wedding_images')
       .child('${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}');
          await ref.putFile(image);
          final url = await ref.getDownloadURL();
            return {
               'downloadUrl': url,
               'path': ref.fullPath,
         };
      }
}
