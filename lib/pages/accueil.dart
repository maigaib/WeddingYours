
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

    final prestataires = [
      {
       "type" : "photo",
       "nom" : "Mali View",
       "image" : "wedding couple"
      },
      {
       "type" : "photo",
       "nom" : "Mali View",
       "image" : "bijoux"
      }
    ];

    Widget buildCard(String imagePath, String title, String subtitle) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Conteneur de l'image avec une hauteur personnalisée
        Container(
          width: double.infinity,
          height: 150,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        // Titre et icône centrés
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Titre
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 10),
                // Icône
                Icon(Icons.star, color: Colors.yellow),
              ],
            ),
            SizedBox(height: 10),
            // Sous-titre
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        //const SizedBox(height: 10),
      ],
    ),
  );
}

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        title : Image.asset("assets/images/LogoMini.png"),
        //backgroundColor: Color.fromRGBO(253, 139, 139, 1),
        backgroundColor: Colors.white,
        //elevation: 50.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu,
            color: Color.fromRGBO(253, 139, 139, 1),
            ),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ), //IconButton
         //IconButton
        ], //<W
        ),
       
             body: Padding(
  padding: const EdgeInsets.only(top: 20),
  child: SingleChildScrollView(
    child: Center(
      child: Column(
        children: <Widget>[
           Container(
        alignment: Alignment.centerLeft, // Alignez le sous-titre à gauche
        padding: const EdgeInsets.only(left: 20),
            child: const Text("Nos Offres",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                      ),
                      ),
         Container(
          width: 350,
          child: CarouselSlider(
  options: CarouselOptions(
    height: 280,
    enableInfiniteScroll: true,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 3),
    autoPlayAnimationDuration: Duration(milliseconds: 800),
    autoPlayCurve: Curves.fastOutSlowIn,
    enlargeCenterPage: true,
  ),
  items: <Widget>[
    // Exemple d'élément de carrousel (vous pouvez en ajouter davantage)
    buildCard("assets/images/mariee 1.png", "Flowers House", "10% de reduction"),
    buildCard("assets/images/hdressing.png", "Autre Robes", "20% de reduction"),
  ],
),


         ),
      Container(
        alignment: Alignment.centerLeft, // Alignez le sous-titre à gauche
        padding: const EdgeInsets.only(left: 20),
            child: const Text("Nos Prestataires",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                      ),
                      ),
          ListView.builder(
            shrinkWrap: true, // Ajoutez cette ligne pour que le ListView s'adapte à son contenu
            itemCount: prestataires.length,
            itemBuilder: (context, index) {
              final prestataire = prestataires[index];
              final img = prestataire['image'];
              final nom = prestataire['nom'];

              return Container(
                width: 30,
                child:Card(
                child: ListTile(
                  leading: Image.asset("assets/images/$img.png"),
                  title: Text('$nom'),
                ),
              ),
              );
            },
          ),
          Container(
        alignment: Alignment.centerLeft, // Alignez le sous-titre à gauche
        padding: const EdgeInsets.only(left: 20),
            child:  const Text("Nos Mariages",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                      ),
              ),
          CarouselSlider(
              options: CarouselOptions(
                height: 200, // Hauteur du carrousel
                enableInfiniteScroll: true, // Activer le défilement infini
                autoPlay: false, // Lancer la lecture automatique
                autoPlayInterval: Duration(seconds: 3), // Interval de lecture automatique (3 secondes)
                autoPlayAnimationDuration: Duration(milliseconds: 800), // Durée de l'animation de lecture automatique
                autoPlayCurve: Curves.fastOutSlowIn, // Courbe d'animation de lecture automatique
                enlargeCenterPage: true, // Agrandir la page du centre
              ),
              items: <Widget>[
                // Exemple d'élément de carrousel (vous pouvez en ajouter davantage)
                Card(
                  child: Image.asset("assets/images/mariee 1.png"),
                ),
                Card(
                  child: Image.asset("assets/images/wedding couple.png"),
                ),
                Card(
                  child: Image.asset("assets/images/mariee 1.png"),
                ),
              ],
            ),


        ],
      ),
    ),
  ),
)

      ),
                );

          }
        }