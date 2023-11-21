import 'package:flutter/material.dart';
class Taches extends StatefulWidget {
  const Taches({super.key});

  @override
  State<Taches> createState() => _TachesState();
}

class _TachesState extends State<Taches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Mettez ici la logique pour retourner en arrière
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Mes Taches',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),

      body: Column(
        children: [
          Center(
            child: Container(
              height: 250, // Ajustez la hauteur selon vos préférences
              width: 350, // Ajustez la largeur selon vos préférences
              child:  Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            SizedBox(height:6),
                          Container(
                           width:70,
                              height: 70,
                            child: Image.asset(
                      "assets/images/galerie.png",
                      fit: BoxFit.contain,
                            ),
                          ),
                          const Text(
                      "Galerie",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      
                    ),
            ),
          )


        ],
      ),


      );
  }
}