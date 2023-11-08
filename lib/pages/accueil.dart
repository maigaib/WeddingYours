
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

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title : Image.asset("assets/images/LogoMini.png"),
        backgroundColor: Color.fromRGBO(253, 139, 139, 1),
        //elevation: 50.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ), //IconButton
         //IconButton
        ], //<W
        ),
       // systemOverlayStyle: SystemUiOverlayStyle.light,
         // SizedBox(height: 20,),
   
             body: Padding(
  padding: const EdgeInsets.only(top: 20),
  child: SingleChildScrollView(
    child: Center(
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "assets/images/hdressing.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Card Title",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Card Subtitle",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.star, color: Colors.yellow),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true, // Ajoutez cette ligne pour que le ListView s'adapte à son contenu
            itemCount: prestataires.length,
            itemBuilder: (context, index) {
              final prestataire = prestataires[index];
              final img = prestataire['image'];
              final nom = prestataire['nom'];

              return Card(
                child: ListTile(
                  leading: Image.asset("assets/images/$img.png"),
                  title: Text('$nom'),
                ),
              );
            },
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