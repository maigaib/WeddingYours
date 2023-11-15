import 'package:app_wedding_yours/pages/mariageAdd.dart';
import 'package:app_wedding_yours/pages/mariage_content.dart';
import 'package:flutter/material.dart';

class Mariages extends StatefulWidget {
  const Mariages({Key? key}) : super(key: key);

  @override
  State<Mariages> createState() => _MariagesState();
}

class _MariagesState extends State<Mariages> {

  Widget buildCardM(String imagePath, String title) {
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
            height: 120,
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
                  const SizedBox(width: 6),
                  // Icône
                  Icon(Icons.remove_red_eye),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Image.asset("assets/images/LogoMini.png"),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color.fromRGBO(253, 139, 139, 1),
            ),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Row(
            children: <Widget>[
              Expanded(
                child:InkWell(
                      onTap: () {
                        // Ajoutez ici la logique de navigation
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MariageContent()),
                        );
                      },
                child: Container(
                  //color: Colors.blue,
                  height: 180,
                  child: Center(
                    child: buildCardM("assets/images/hdressing.png", "Mariage 1"),
                  ),
                ), 
                ),
              ),
              Expanded(
                child:InkWell(
                        onTap: () {
                          // Ajoutez ici la logique de navigation
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MariageContent()),
                          );
                        },
                child: Container(
                  //color: Colors.green,
                  height: 180,
                  child: Center(
                    child: buildCardM("assets/images/mariee 1.png", "Mariage 2"),
                  ),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 300, // Largeur du bouton
        height: 40,
        margin: const EdgeInsets.only(top: 10, bottom: 10, right: 20), // Marge supérieure
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Color.fromRGBO(253, 139, 139, 1),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          onPressed: () {
            // Ajoutez ici la logique de connexion
            // Vous pouvez naviguer vers la page d'accueil une fois la connexion réussie
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MariageAdd()),
            );
          },
           child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
        Icons.add, // Icône que vous souhaitez ajouter
        size: 24, // Taille de l'icône
        ),
        SizedBox(width: 10), // Espace entre l'icône et le texte
        Text(
        'Ajouter',
        style: TextStyle(
          fontSize: 24,
          //fontFamily: 'Poppins',
        ),
        ),
      ],
        ),
        ),
      ),
    );
  }
}
