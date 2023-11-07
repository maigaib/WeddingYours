
import 'package:flutter/material.dart';

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

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Accueil"),
        ),
        body:
         Center(
               child: ListView.builder(
                  itemCount: prestataires.length,
                  itemBuilder: (context, index) {
                    final prestataire = prestataires[index];
                    final img = prestataire['image'];
                    final nom = prestataire['nom'];

                  return  Card(
                        child: ListTile(
                          leading: Image.asset("assets/images/$img.png"),
                          title: Text('$nom'),
                        ),
                      );
                  }, 
               )
          ),
          
        ),
        );

  }
}