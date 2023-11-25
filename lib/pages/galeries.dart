// import 'dart:io';
// import 'dart:typed_data';
// import 'package:app_wedding_yours/modeles/imageModel.dart';
// import 'package:app_wedding_yours/services/galerieService.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';


// class Galeries extends StatefulWidget {
//   final String mariageId;

//   const Galeries({Key? key, required this.mariageId}) : super(key: key);

//   @override
//   State<Galeries> createState() => _GaleriesState();
// }

// class _GaleriesState extends State<Galeries> {
//   List<ImageModel> images = [];
//   final GalerieService galerieService = GalerieService();

//   Future<void> chargerImages() async {
//     final galerieImages = await galerieService.getImagesByMariageId(widget.mariageId);
//     List<ImageModel> imageModels = galerieImages.map((url) => ImageModel(imageUrl: url)).toList();
//     setState(() {
//       images = imageModels;
//     });
//   }

//   Future<void> ajouterImages() async {
//     List<Asset> imagesAssets = [];
//     try {
//       imagesAssets = await MultiImagePicker.pickImages(
//         maxImages: 10 - images.length,
//         enableCamera: true,
//       );
//     } on Exception catch (e) {
//       print('Erreur lors de la sélection des images : $e');
//     }

//     if (imagesAssets.isNotEmpty) {
//       List<File> imageFiles = [];
//       for (Asset asset in imagesAssets) {
//         final ByteData byteData = await asset.getByteData();
//         final List<int> imageData = byteData.buffer.asUint8List();
//         final File imageFile = File('${(await getTemporaryDirectory()).path}/${asset.name}')
//           ..writeAsBytesSync(imageData);
//         imageFiles.add(imageFile);
//       }

//       await galerieService.uploadImages(widget.mariageId, imageFiles);
//       await chargerImages();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     chargerImages();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Galerie'),
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//         ),
//         itemCount: images.length,
//         itemBuilder: (context, index) {
//           return Image.network(
//             images[index].imageUrl,
//             fit: BoxFit.cover,
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => ajouterImages(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
