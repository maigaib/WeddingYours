import 'package:flutter/material.dart';
class MariageContent extends StatelessWidget {
  const MariageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Stack(
            children: [
              // Image en fond d'écran
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: SizedBox(
                      height: 250,
                      child: Image.asset(
                        'assets/images/alliance main 1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              // Icône de retour
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Mettez ici la logique pour retourner en arrière
                    Navigator.pop(context);
                  },
                ),
              ),
              // Textes centrés
              const Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'M. & Mme',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height:20),
                    Text(
                      '2 Avril 2025',
                      style: TextStyle(
                        color: Color.fromRGBO(253, 139, 139, 1),
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height:20),

                    Text(
                      '. 524 jour j',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
            ],
              ),
              ),
              

            ]
              ),
       
       Column(
            children: [
              Row(
                children: [
                  Center(
                    child: Container(
                        width:125,
                        height: 130,
                      child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            SizedBox(height:10),
                          Container(
                           width:40,
                              height: 40,
                            child: Image.asset(
                      "assets/images/bijoux.png",
                      fit: BoxFit.contain,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                      "Votre texte ici",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      
                    ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
     );
  }
}