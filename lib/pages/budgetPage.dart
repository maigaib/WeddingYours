import 'dart:async';

import 'package:app_wedding_yours/modeles/depense.dart';
import 'package:app_wedding_yours/services/depenseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  StreamController<List<Depense>> _depensesController = StreamController<List<Depense>>.broadcast();
   final _formkey = GlobalKey<FormState>();

   final  montantController = TextEditingController();
    final  descriptionController = TextEditingController();
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
          'Mon Budget',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 180,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 8,),
                        Container(
                          width: 70,
                          height: 70,
                          padding: EdgeInsets.all(10.0),
                          child: Image.asset(
                            "assets/images/cochon.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text('MONTANT ESTIME'),
                        SizedBox(height: 2,),
                        const Text(
                          '13000000',
                          style: TextStyle(
                              //color: Color.fromRGBO(253, 139, 139, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        SizedBox(height: 4,),

                        GestureDetector(
                          onTap: () {
                            // Action à effectuer lors du clic sur le texte
                            print('Texte cliqué !');
                          },

                          child:
                          
                           Text(
                            'Modifier',
                            style: TextStyle(
                              color: Color.fromRGBO(253, 139, 139, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  VerticalDivider(
                    color: Colors.grey, // Couleur de la ligne verticale
                    thickness: 1, // Épaisseur de la ligne verticale
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 12,),
                        Container(
                          width: 70,
                          height: 70,
                          padding: EdgeInsets.all(10.0),
                          child: Image.asset(
                            "assets/images/depense2.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text('COUT FINAL'),
                        SizedBox(height: 5,),
                        const Text(
                          '13000000',
                          style: TextStyle(
                              //color: Color.fromRGBO(253, 139, 139, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

         // Liste de tâches
  StreamBuilder<List<Depense>>(
  stream: _depensesController.stream,
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }
    // Utilisez les données du snapshot
    List<Depense> depenseList = snapshot.data as List<Depense>;

    return Expanded(
  child: ListView.builder(
    itemCount: depenseList.length * 2 - 1,
    itemBuilder: (context, index) {
      if (index.isOdd) {
        return Divider(height: 1); // Réduisez la hauteur du Divider à 0
      }

      final indexDepense = index ~/ 2;
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        child: ListTile(
          title: Text(depenseList[indexDepense].description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {

                  // Afficher le modal pour la modification
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 350,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Modifier Depense',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color:  Color(0xFFFC8B8B)), // Couleur de la bordure lorsque le champ est en focus
                                borderRadius: BorderRadius.circular(8),),
                              labelText: 'Titre',
                              labelStyle: TextStyle(color:  Colors.black),
                              hintText: 'Titre',
                              hintStyle: TextStyle(color:  Colors.black)
                              //hintStyle: TextStyle(color:  Color(0xFFFC8B8B))
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
                            controller: montantController,
                           // initialValue: selectedTask?.nom ?? '', 
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color:  Color(0xFFFC8B8B)), // Couleur de la bordure lorsque le champ est en focus
                                borderRadius: BorderRadius.circular(8),),
                              labelText: 'Description',
                              hintText: 'Description',
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
                            controller: descriptionController,
                            //initialValue: selectedTask?.nom ?? '', 
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Container(
                      width: 300,
                      height: 40,
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
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
                          
                        },
                        child: Text(
                          'Valider',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                            // Ajoutez ici les champs de modification et les boutons
                          ],
                        ),
                      );
                    },
                  );
                },
            
              ),
              IconButton(
                icon: Icon(Icons.delete,
                color: Colors.red,),
                onPressed: () {
                  
                    // Navigator.of(context).restorablePush((context, arguments) => _dialogBuilder(
                    // context,
                    // arguments,
                    // depenseService,  // Passez tacheService en tant qu'argument
                    //selectedDepense,  // Passez selectedTask en tant qu'argument
                   // fetchTasksList,
                 // ));
                },
              ),
            ],
          ),
        ),
      );
    },
  ),
);

  },
),

//list end
 Divider(
        color: Colors.grey[400],
        thickness: 1,
      ),
   GestureDetector(
  onTap: () {
    // Affiche le modal bottom sheet lorsque le texte est cliqué
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Le contenu du modal bottom sheet
        return Container(
          height: 400,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Nouvel Tache',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color:  Color(0xFFFC8B8B)), // Couleur de la bordure lorsque le champ est en focus
                                borderRadius: BorderRadius.circular(8),),
                              labelText: 'Titre',
                              labelStyle: TextStyle(color:  Colors.black),
                              hintText: 'Titre',
                              hintStyle: TextStyle(color:  Colors.black)
                              //hintStyle: TextStyle(color:  Color(0xFFFC8B8B))
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
                            controller: nomController,
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
                              suffixIcon: const Icon(
                                Icons.calendar_today,
                                color: Color(0xFFFC8B8B),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFFC8B8B),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey, // Changer la couleur de la bordure lorsque le champ est désactivé
                                ),
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color:  Color(0xFFFC8B8B)), // Couleur de la bordure lorsque le champ est en focus
                                borderRadius: BorderRadius.circular(8),),
                              labelText: 'Description',
                              hintText: 'Description',
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
                            controller: descriptionController,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Container(
                      width: 300,
                      height: 40,
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
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
                          if(_formkey.currentState!.validate()){
                              final nom = nomController.text;
                              final description = descriptionController.text;
                              final status = statusController.text;
                              
                            final dd = Depense(
                                depenseId: '',
                                depenseMontant: depenseMontant,
                                description: description,

                                
                              );

                              depenseService.create(dd);
                             // fetchTasksList();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Envoi en cours ...")),
                          );
                          FocusScope.of(context).requestFocus(FocusNode());
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Ajouter',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  },
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.add_circled,
          color: Color.fromRGBO(253, 139, 139, 1),),
          SizedBox(width: 8),
          Text(
            'Ajouter',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color:Color.fromRGBO(253, 139, 139, 1), 
            ),
          ),
        ],
      ),
      Divider(
        color: Colors.grey[400],
        thickness: 1,
      ),
    ],
  ),
),
SizedBox(height: 3),
         
        ],
      ),
    );
  }
}
