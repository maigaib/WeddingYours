import 'dart:io';
import 'package:app_wedding_yours/pages/amisPage.dart';
import 'package:app_wedding_yours/pages/famillePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class Invites extends StatefulWidget {
  const Invites({Key? key}) : super(key: key);

  @override
  State<Invites> createState() => _InvitesState();
}

class _InvitesState extends State<Invites> {
  final _formkey = GlobalKey<FormState>();
  late File _excelFile;
  String currentFilter = 'Tout'; // Filtre actif par défaut
  // Définir la méthode pour créer un conteneur de filtre
  Widget myFilterContainer(String label, VoidCallback onPressed, bool isActive) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Color.fromRGBO(253, 139, 139, 1) : Colors.white,
          foregroundColor: isActive ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isActive ? Colors.grey : Color.fromARGB(255, 82, 83, 84),
            ),
          ),
        ),
        child: Text(label),
      ),
    );
  }

  // Définir la méthode pour changer le filtre
  void changeFilter(String newFilter) {
    setState(() {
      currentFilter = newFilter;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Mes Invites',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.upload,
              color: Colors.black,
            ),
            tooltip: 'Upload Icon',
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['xlsx', 'xls'],
              );

              if (result != null) {
                setState(() {
                  _excelFile = File(result.files.single.path!);
                });

                await processExcelFile(_excelFile);
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('excelData').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var excelData = snapshot.data!.docs;

          return Column(
            children: [
            SizedBox(height: 6,),
              Container(
  height: 60,
  padding: const EdgeInsets.all(0),
  child: Row(
    //scrollDirection: Axis.horizontal,
    children: [
      Expanded(
        child: myFilterContainer('Tout', () => changeFilter('Tout'),
            currentFilter == 'Tout'),
      ),
      Expanded(
        child: myFilterContainer('Famille', () {
          setState(() {
            currentFilter = 'Famille';
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FamillePage()));
        }, currentFilter == 'Famille'),
      ),
      Expanded(
        child: myFilterContainer('Ami(e)s', () {
          setState(() {
            currentFilter = 'Ami(e)s';
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AmisPage()));
        }, currentFilter == 'Ami(e)s'),
      ),
    ],
  ),
),
            SizedBox(height: 4,),
            Divider( // Utiliser un Divider pour le trait horizontal
        color: Colors.grey[400],
        thickness: 1, // Épaisseur du trait
      ),
            SizedBox(height: 3,),
            Center(child: Text('Liste des invites',
                      style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),),
          ),
            SizedBox(height: 4,),
            Divider( // Utiliser un Divider pour le trait horizontal
        color: Colors.grey[400],
        thickness: 1, // Épaisseur du trait
      ),
            SizedBox(height: 6,),
              Expanded( // Utilisez Expanded pour que la liste prenne tout l'espace disponible
              child:SingleChildScrollView(
              child:Column(
                children: [
                   ListView.builder(
                    shrinkWrap: true, // Permet au ListView de réduire sa taille pour s'adapter au contenu
                    physics: NeverScrollableScrollPhysics(), // Désactive le défilement du ListView
                    itemCount: excelData.length,
                    itemBuilder: (context, index) {
                      var data = excelData[index].data() as Map<String, dynamic>;

                      // Utilisez une liste de widgets pour afficher dynamiquement les colonnes
                      List<Widget> columnWidgets = [];

                      data.forEach((key, value) {
                        columnWidgets.add(
                          Text('$key: $value'),
                        );
                      });

                      return Card(
                        child: Column(
                          children: columnWidgets,
                        ),
                      );
                    },
                  ),
                ],
              ),
              ),),
              SizedBox(height: 4,),
            Divider( // Utiliser un Divider pour le trait horizontal
                color: Colors.grey[400],
                thickness: 1, // Épaisseur du trait
              ),
            //SizedBox(height: 2,),
                      Container(
  width: 300,
  height: 45,
  margin: const EdgeInsets.only(top: 10, bottom: 10),
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
      // Affiche le modal bottom sheet lorsque le bouton est cliqué
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
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
                         child:Text('Nouvel Invites',
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
                              labelText: 'Nom',
                              labelStyle: TextStyle(color:  Color(0xFFFC8B8B)),
                              hintText: 'Nom',
                              
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
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
                              labelText: 'Prenom',
                              hintText: 'Prenom',
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
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
                              labelText: 'Telephone',
                              hintText: 'Telephone',
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
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
                              labelText: 'Email',
                              hintText: 'Email',
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                      Container(
                        width: 300, // Largeur du bouton
                        height: 40,
                        margin: const EdgeInsets.only(top: 8, bottom: 8), // Marge supérieure
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
                             
                                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Envoi en cours ..."))
                                );
                                FocusScope.of(context).requestFocus(FocusNode());
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.add_circled),
        SizedBox(width: 8),
        Text(
          'Ajouter',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ),
),
                     // SizedBox(height: 2,),
                      Divider( // Utiliser un Divider pour le trait horizontal
                  color: Colors.grey[400],
                  thickness: 1, // Épaisseur du trait
                ),
            SizedBox(height: 3,),
            ],
          );
        },
      ),
    );
  }

  Future<void> processExcelFile(File file) async {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      var data = excel.tables[table]!.rows;

      for (var row in data) {
        // Créez un Map pour stocker les données de la ligne
        Map<String, dynamic> rowData = {};

        // Parcourez toutes les colonnes de la ligne
        for (var i = 0; i < row.length; i++) {
          rowData['column$i'] = row[i]?.toString() ?? '';
        }

        // Ajoutez les données à Firebase
        await FirebaseFirestore.instance.collection('excelData').add(rowData);
      }
    }
  }
}
