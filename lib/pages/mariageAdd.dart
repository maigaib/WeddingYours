import 'dart:io';

import 'package:app_wedding_yours/pages/mariages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MariageAdd extends StatefulWidget {
  const MariageAdd({Key? key}) : super(key: key);

  @override
  _MariageAddState createState() => _MariageAddState();
}

class _MariageAddState extends State<MariageAdd> {
  //========================= pour image upload =========================================
final ImagePicker _picker = ImagePicker(); // Ajout de la déclaration de _picker
 String? imagePath; // Ajout de la variable pour le chemin de l'image

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }
//================================ for date ====================================
 DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
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
                              child:Text('Nouveau Mariage',
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
                                labelText: 'Monsieur',
                                hintText: 'Monsieur',
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
                                labelText: 'Madame',
                                hintText: 'Madame',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 300,
                                child: TextFormField(
                                    validator: (value) {
                                      if (selectedDate == null) {
                                        return 'Veuillez sélectionner une date';
                                      }
                                      return null; // La validation a réussi
                                    },
                                    decoration: InputDecoration(
                                      //labelText: 'Sélectionnez une date :',
                                      suffixIcon: Icon(Icons.calendar_today), // Ajoutez ici l'icône de calendrier
                                      border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8.0), // Ajoutez le rayon ici
                                            ),
                                    ),
                                    onTap: () => _selectDate(context),
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text: selectedDate != null
                                          ? '${selectedDate!.toLocal()}'.split(' ')[0]
                                          : 'Sélectionnez une date',
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
                                labelText: 'Lieu',
                                hintText: 'Lieu',
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
                         Container(
                          width: 300, // Largeur du bouton
                          height: 50,
                          margin: const EdgeInsets.only(top: 10, bottom: 10), // Marge supérieure
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.grey[300],
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: Colors.grey), // Couleur de la bordure
                                ),
                              ),
                              alignment: Alignment.centerLeft, // Aligner le contenu à gauche
                            ),
                            onPressed: () => _pickImage(),
                            child: const Text(
                              'Ajouter Image',
                            
                              style: TextStyle(
                                fontSize: 18,
                                color  : Colors.grey
      
                               // fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
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
                              Navigator.pop(
                                context,
                                MaterialPageRoute(builder: (context) => Mariages()),
                              );
                            },
                            child: const Text(
                              'Ajouter',
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
