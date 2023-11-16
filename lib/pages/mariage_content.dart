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
         SizedBox(height:10),
         Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    SizedBox(width: 1),
    Icon(Icons.location_on, color: Colors.grey),
    Text('Bamako, Mali'),
    SizedBox(width: 40),
    GestureDetector(
      onTap: () {
        // Action à effectuer lors du clic sur l'icône
        print('Icône cliquable cliquée !');
      },
      child: Icon(Icons.edit_document, color: Colors.grey),
    ),
    SizedBox(width: 2),
  ],
),

         SizedBox(height:10),
       
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
                      "assets/images/icons8-wallet-64.png",
                      fit: BoxFit.contain,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                      "Budget",
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

                  Container(
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
                      "Taches",
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
//============================================================================================
                  Container(
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
                      "Invites",
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
                ],
              ),
              //================================================================ 2 eme ligne
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
                      "Favories",
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

                  Container(
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
                      "Galerie",
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
                ],
              ),
            ],
          )
        ],
      ),
     );
  }
}