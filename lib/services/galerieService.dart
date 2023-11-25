import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class GalerieService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> getImagesByMariageId(String mariageId) async {
    List<String> imageUrls = [];

    try {
      final ListResult result = await _storage.ref('galerie/$mariageId/').list();
      for (final Reference ref in result.items) {
        final String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    } catch (e) {
      print('Erreur lors de la récupération des images : $e');
    }

    return imageUrls;
  }

  Future<void> uploadImage(String mariageId, File imageFile) async {
    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageReference = _storage.ref('galerie/$mariageId/$fileName.png');
      await storageReference.putFile(imageFile);
    } catch (e) {
      print('Erreur lors du téléchargement de l\'image : $e');
      throw e;
    }
  }
   Future<void> uploadImages(String mariageId, List<File> imageFiles) async {
    for (int i = 0; i < imageFiles.length; i++) {
      File imageFile = imageFiles[i];
      String imageName = 'image_$i.png';

      // Créer une référence pour l'image dans Firebase Storage
      Reference storageReference = _storage.ref().child('images/$mariageId/$imageName');

      // Télécharger l'image dans Firebase Storage
      await storageReference.putFile(imageFile);

      // Récupérer l'URL de l'image téléchargée
      String imageUrl = await storageReference.getDownloadURL();

      // Vous pouvez maintenant utiliser imageUrl comme nécessaire (par exemple, le sauvegarder dans une base de données)
      print('Image $i téléchargée avec succès. URL : $imageUrl');
    }
  }
}
