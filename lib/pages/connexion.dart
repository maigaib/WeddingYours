import 'package:app_wedding_yours/pages/accueil.dart';
import 'package:app_wedding_yours/pages/inscription.dart';
import 'package:flutter/material.dart';
class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("Accueil"),
        // ),
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              Image.asset("assets/images/LogoV.png"),
              const SizedBox(height: 40,),
              Image.asset("assets/images/wedding couple.png"),
              
              const Text("Bienvenu",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
              ),
              ),
                Expanded(
                   child: Card(
                     shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),   // Coin supérieur gauche
                          topRight: Radius.circular(40),  // Coin supérieur droit
                        ),
                        ),
                  child: SizedBox(
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelText: 'Email',
                                hintText: 'Email',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 300,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelText: 'Mot de passe',
                                hintText: 'Mot de passe',
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 30,),
                        Container(
                        width: 300, // Largeur du bouton
                        height: 40,
                        margin: const EdgeInsets.only(top: 10, bottom: 10), // Marge supérieure
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
                              MaterialPageRoute(builder: (context) => Accueil()),
                            );
                          },
                          child: const Text('Connexion',
                          style: TextStyle(
                          fontSize: 24,
                          //fontFamily: 'Poppins',
                        ),
                        ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      const Text("Vous n'avez pas de compte ?",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                      ),
                      InkWell(
                          onTap: () {
                            // Ajoutez ici la logique pour naviguer vers la page d'inscription
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Inscription()));
                          },
                          child: const Text(
                            "S'inscrire",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              color: Color.fromRGBO(253, 139, 139, 1),
                            ),
                          ),
                        ),
                      SizedBox(height: 30,),

                      ],
                    ),
                  ),
                ),
              ),
                ),
            ],
          ),
        ),
        ),
    );
  }
}