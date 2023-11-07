import 'package:app_wedding_yours/pages/connexion.dart';
import 'package:flutter/material.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60),
            Image.asset("assets/images/LogoV.png"),
            const SizedBox(height: 50),

            Expanded(
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), // Coin supérieur gauche
                    topRight: Radius.circular(40), // Coin supérieur droit
                  ),
                ),
    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                         Container(
                          margin: EdgeInsets.only(top:0,),
                            width: double.infinity, // Prend toute la largeur du Card
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFC8B8B),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child:const Center(
                              child:Text('Utilisateur',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                color: Colors.white
                              )
                              ),
                            ) 
                          ),
                              const SizedBox(height: 50),

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
                                labelText: 'Nom',
                                hintText: 'Nom',
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
                                labelText: 'Prenom',
                                hintText: 'Prenom',
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
                                labelText: 'Telephone',
                                hintText: 'Telephone',
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
                                labelText: 'Adresse',
                                hintText: 'Adresse',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: 300, // Largeur du bouton
                          height: 50,
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
                                MaterialPageRoute(builder: (context) => Connexion()),
                              );
                            },
                            child: const Text(
                              'Inscription',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
              ),
            
          ],
        ),
    ),
    );
  }
}
