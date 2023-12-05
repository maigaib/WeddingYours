
import 'package:app_wedding_yours/modeles/budget.dart';
import 'package:app_wedding_yours/modeles/mariage.dart';
import 'package:app_wedding_yours/pages/budgetPage.dart';
import 'package:app_wedding_yours/pages/favories.dart';
import 'package:app_wedding_yours/pages/galeries.dart';
import 'package:app_wedding_yours/pages/invites.dart';
import 'package:app_wedding_yours/pages/mariageMod.dart';
import 'package:app_wedding_yours/pages/taches.dart';
import 'package:app_wedding_yours/services/budgetService.dart';
import 'package:app_wedding_yours/services/mariagesServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:app_wedding_yours/pages/fonctions.dart';
//import 'package:app_wedding_yours/controllers/mariagesController.dart';
class MariageContent extends StatelessWidget {
  final String mariageId;
  final MariagesService _service; // Ajoutez cette ligne pour déclarer le service
  const MariageContent({Key? key, required this.mariageId, required MariagesService service})
      : _service = service,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<Mariage>(
        future: _service.getMariageById(mariageId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('Aucune donnée trouvée');
          } else {
            Mariage mariageDetails = snapshot.data!;
      
      DateTime dateDuMariage = mariageDetails.date;
      DateTime dateActuelle = DateTime.now();
      Duration difference = dateDuMariage.difference(dateActuelle);
      int jour = difference.inDays;

     return Column(
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
                          child: Image.network(
                            mariageDetails.photo, // Utilisez la propriété photo de mariageDetails
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                              // Gestionnaire d'erreur, affiche une image de remplacement en cas d'erreur
                              return Image.asset(
                                'assets/images/alliance main 1.png', // Chemin de votre image de remplacement
                                fit: BoxFit.cover,
                              );
                            },
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
               Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                     capitalize(mariageDetails.monsieur) +' & '+ capitalize(mariageDetails.madame),
                      style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),
                    ),
                    SizedBox(height:20),
                    Text(
                      DateFormat('dd MMMM yyyy').format(mariageDetails.date),
                      style: TextStyle(
                        color: Color.fromRGBO(253, 139, 139, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,

                      ),
                    ),
                    SizedBox(height:20),

                    Text(
                      '. $jour jour j',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,

                      ),
                    ),
            ],
              ),
              ),
              

            ]
              ),
         SizedBox(height:10),
         Row(
          crossAxisAlignment: CrossAxisAlignment.start,
  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    SizedBox(width: 6),
    Icon(Icons.location_on, color: Colors.grey),
    SizedBox(width: 15),
    Container( width: 100, child:  Baseline(
                baseline: 20.0, // Ajustez la valeur en fonction de vos besoins
                baselineType: TextBaseline.alphabetic,
                child:Text( capitalize(mariageDetails.lieu),
                  style: GoogleFonts.inter(
                              fontSize: 18,
                          
                              fontWeight: FontWeight.w500,
                            ),))),
    SizedBox(width: 210),
    GestureDetector(
      onTap: () {
        Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MariageMod(mariageDetails: mariageDetails, mariagesServices: _service),
      ),
    );
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
                        height: 120,
                      child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: GestureDetector(
                      onTap: () async {
                      // Vérifier si le mariage a déjà un budget
                      final existingBudget = await BudgetService().getBudgetByMariageId(mariageDetails.mariageId ?? '');

                      if (existingBudget != null) {
                        // Un budget existe déjà pour ce mariage, vous ne faites rien ici
                        print('Un budget existe déjà pour ce mariage.');
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BudgetPage(nouveauBudget: existingBudget, mariageId: mariageDetails.mariageId)),
                        );
                      } else {
                        // Aucun budget existant, vous pouvez créer un nouveau budget
                        final newBudget = Budget(
                          budgetId: '',
                          budgetMontant: 00,
                          mariageId: mariageDetails.mariageId ?? '',
                        );
                        await newBudget.createBudget(mariageDetails.mariageId ?? '');

                        // Naviguer vers la page BudgetPage avec le nouveauBudget
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BudgetPage(nouveauBudget: newBudget, mariageId: mariageDetails.mariageId)),
                        );
                      }
                    },

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            SizedBox(height:6),
                          Container(
                           width:70,
                              height: 70,
                              padding: EdgeInsets.all(10.0),
                            child: Image.asset(
                      "assets/images/icons8-wallet-64.png",
                      fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                      "Budget",
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
                  ),
                  ),
                  Container(
                        width:125,
                        height: 120,
                      child: GestureDetector(
    onTap: () {
      // Action à effectuer lors du clic sur le Card
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Taches(mariageId: mariageDetails.mariageId ?? '')), // Remplacez "NouvellePage" par le widget de votre nouvelle page
      );
    },
    child : Card(
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
                      "assets/images/tache3.png",
                      fit: BoxFit.contain,
                            ),
                          ),
                          const Text(
                      "Taches",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      
                    ),
                    )
                    ),
//============================================================================================
                  Container(
                        width:125,
                        height: 120,
                      child: 
                      GestureDetector(
                          onTap: () {
                            // Action à effectuer lors du clic sur le Card
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Invites()), // Remplacez "NouvellePage" par le widget de votre nouvelle page
                            );
                          },
                     child: Card(
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
                      "assets/images/invites.png",
                      fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                      "Invites",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                     ) 
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
                        height: 120,
                      child: GestureDetector(
                        onTap: () {
                          // Action à effectuer lors du clic sur le Card
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Favories()), // Remplacez "NouvellePage" par le widget de votre nouvelle page
                          );
                        },
                      
                     child: Card(
                      //color: Colors.white,
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
                      "assets/images/icons8-coeurs-48.png",
                      fit: BoxFit.contain,
                            ),
                          ),
                          const Text(
                      "Favories",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      
                    ),
                    )
                    ),
                  ),

                  Container(
                        width:125,
                        height: 120,
                      child: GestureDetector(
                          onTap: () {
                            // Action à effectuer lors du clic sur le Card
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Galeries(mariageId: mariageDetails.mariageId ?? '')), 
                            );
                          },
                      
                     child: Card(
                      elevation: 5,
                      //color: Colors.white,
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
                   ),
                ],
              ),
            ],
          )
        ],
      );
  }
  }
  )
  );
  }
}