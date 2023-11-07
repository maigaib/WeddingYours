import 'package:app_wedding_yours/pages/accueil.dart';
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
              Image.asset("assets/images/wedding couple.png"),
              const Text("Bienvenu",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
              ),
              ),
            Padding(padding: EdgeInsets.only(top: 10)),
            ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(253, 139, 139, 1))
            ),
            onPressed: () {
              Navigator.push(
                context, 
                PageRouteBuilder(
                  pageBuilder: (_,__,___) => Accueil()
                  )
                );
            },
            child: const Text('Connexion'),
          ),
            ],
          ),
        ),
        ),
    );
  }
}