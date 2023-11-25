import 'dart:io';
import 'package:app_wedding_yours/modeles/imageModel.dart';
import 'package:app_wedding_yours/services/galerieService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Galeries extends StatefulWidget {
  final String mariageId;

  const Galeries({Key? key, required this.mariageId}) : super(key: key);

  @override
  State<Galeries> createState() => _GaleriesState();
}

class _GaleriesState extends State<Galeries> {
  List<ImageModel> images = [];
  final GalerieService galerieService = GalerieService(); // Instanciez votre service Galerie

 Future<void> chargerImages() async {
  // Chargez les images liées au mariage
  final galerieImages = await galerieService.getImagesByMariageId(widget.mariageId);

  // Convertir List<String> en List<ImageModel>
  List<ImageModel> imageModels = galerieImages.map((url) => ImageModel(imageUrl: url)).toList();

  setState(() {
    images = imageModels;
  });
}
  Future<String?> choisirImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }

  Future<void> ajouterImage() async {
    String? imagePath = await choisirImage();
    if (imagePath != null) {
      await galerieService.uploadImage(widget.mariageId, File(imagePath));
      await chargerImages();
    }
  }

  @override
  void initState() {
    super.initState();
    chargerImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galerie'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.network(
            images[index].imageUrl,
            fit: BoxFit.cover,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ajouterImage(),
        child: Icon(Icons.add),
      ),
    );
  }
}