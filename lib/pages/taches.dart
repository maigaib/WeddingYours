import 'dart:async';

import 'package:app_wedding_yours/modeles/tache.dart';
import 'package:app_wedding_yours/services/tacheService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class Taches extends StatefulWidget {
  final String mariageId;
  const Taches({Key? key, required this.mariageId}) : super(key: key);

  @override
  State<Taches> createState() => _TachesState();
}

class _TachesState extends State<Taches> {

StreamController<List<Tache>> _tasksController = StreamController<List<Tache>>.broadcast();

  Tache? selectedTask;
  int touchedIndex = -1;
   final _formkey = GlobalKey<FormState>();
     late TacheService tacheService; 
   void initState() {
    super.initState();
    fetchTasksList(widget.mariageId);
    tacheService = TacheService(); // Initialisez tacheService ici
    // Écouter les mises à jour de la liste de tâches
    tacheService.tasksStream.listen((List<Tache> tasks) {
      // Mettez à jour votre interface utilisateur avec les nouvelles tâches
      print('Liste de tâches mise à jour: $tasks');
    });
    //getTasksList();

  }
   _TachesState();
   List<Tache> tasks = []; // Assurez-vous de définir votre propre modèle de tâche
    
    final  nomController = TextEditingController();
    final  descriptionController = TextEditingController();
    final  statusController = TextEditingController();
    @override
       void dispose(){
    super.dispose();
    nomController.dispose();
    descriptionController.dispose();
    statusController.dispose();
  }
//============
Future<void> fetchTasksList(String mariageId) async {
  try {
    // Utilisation de Firestore pour récupérer les tâches avec le mariageId spécifié
    QuerySnapshot<Map<String, dynamic>> taskSnapshot = await FirebaseFirestore.instance
        .collection('taches')
        .where('mariageId', isEqualTo: mariageId)
        .get();

    // Convertir les documents Firestore en une liste de tâches
    List<Tache> tasksList = taskSnapshot.docs.map((doc) {
      return Tache.fromMap(
          doc.data() as Map<String, dynamic>, doc.reference
      );
    }).toList();

    // Émettre les données à travers le StreamController
    _tasksController.add(tasksList);
  } catch (e) {
    print('Erreur lors de la récupération des tâches: $e');
    _tasksController.addError(e); // Émettre une erreur si la récupération échoue
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

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  //====================================================== modal supprimer ============================================
 // @pragma('vm:entry-point')
   static Route<Object?> _dialogBuilder(
  BuildContext context, Object? arguments, TacheService tacheService, 
  Tache? selectedTask, Function fetchTasksList) {
  return DialogRoute<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation de suppression'),
        content: Text('Voulez-vous vraiment supprimer cette tâche ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer la boîte de dialogue
            },
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              // Supprimer la tâche et fermer la boîte de dialogue
              await tacheService.delete(selectedTask!.tacheId ?? '');
              fetchTasksList();
              Navigator.of(context).pop(); // Fermer la boîte de dialogue
            },
            child: Text('Supprimer'),
          ),
        ],
      );
    },
  );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mes Taches',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
  children: [
    SizedBox(height: 10),
    Center(
      child: Container(
        height: 250, // Définissez une hauteur pour le conteneur parent
        width: 350,
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
            SizedBox(height: 4,),
            Center(child: Text('Taches',
                      style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),),
          ),
           // SizedBox(height: 2,),
             Divider( // Utiliser un Divider pour le trait horizontal
        color: Colors.grey[400],
        thickness: 1, // Épaisseur du trait
      ),
           
              SizedBox(
                height: 140, // Définissez une hauteur pour le PieChart
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse.touchedSection!
                              .touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 20,
                    sections: showingSections(),
                  ),
                ),
              ),
              //SizedBox(height: 4),
              
               Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 15, // Largeur de l'icône de cercle
                    height: 15, // Hauteur de l'icône de cercle
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey, // Couleur de l'icône de cercle 1
                    ),
                  ),
                  SizedBox(width: 8), // Espacement entre l'icône de cercle 1 et le texte
                  Text(
                    'En cours : 0',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 15, // Largeur de l'icône de cercle
                    height: 15, // Hauteur de l'icône de cercle
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFC8B8B),
                    ),
                  ),
                  SizedBox(width: 8), // Espacement entre l'icône de cercle 2 et le texte
                  Text(
                    'Terminer : 0',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 6),

            ],
          ),
        ),
      ),
    ),
//list  here
 // Liste de tâches
  StreamBuilder<List<Tache>>(
  stream: _tasksController.stream,
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }
    // Utilisez les données du snapshot
    List<Tache> tasksList = snapshot.data as List<Tache>;

    return Expanded(
  child: ListView.builder(
   itemCount: tasksList.isEmpty ? 1 : tasksList.length * 2 - 1,
  itemBuilder: (context, index) {
    if (tasksList.isEmpty) {
      // Si la liste est vide, affichez un élément de liste indiquant qu'il n'y a pas de tâches.
      return ListTile(
        title: Text('Aucune tâche disponible'),
        // Ajoutez d'autres propriétés au besoin.
      );
    }
      
      if (index.isOdd) {
        return Divider(height: 1); // Réduisez la hauteur du Divider à 0
      }

      final indexTache = index ~/ 2;
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        child: ListTile(
          title: Text(tasksList[indexTache].nom),
          leading: Checkbox(
            value: tasksList[indexTache].isChecked,
            onChanged: (bool? value) {
              setState(() {
                tasksList[indexTache].isChecked = value ?? false;
              });
            },
            activeColor: Color(0xFFFC8B8B), // Couleur de fond de la case à cocher lorsqu'elle est cochée
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                  selectedTask = tasksList[indexTache];

                  // Mettre à jour les contrôleurs avec les valeurs de la tâche sélectionnée
                  nomController.text = selectedTask?.nom ?? '';
                  descriptionController.text = selectedTask?.description ?? '';
                  statusController.text = selectedTask?.status ?? '';
                  selectedDate = selectedTask?.date;
                });
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
                        'Modifier Tache',
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
                           // initialValue: selectedTask?.nom ?? '', 
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
                            //initialValue: selectedTask?.nom ?? '', 
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
                          if (_formkey.currentState!.validate()) {
                            final nom = nomController.text;
                            final description = descriptionController.text;
                            final status = statusController.text;

                            // instance de Tache avec les modifications
                            final modifiedTask = Tache(
                              tacheId: selectedTask!.tacheId, // Utilisez l'ID de la tâche existante
                              nom: nom,
                              status: status,
                              description: description,
                              date: selectedTask!.date, // Vous pouvez également mettre à jour la date si nécessaire
                              mariageId: selectedTask!.mariageId,
                              isChecked: selectedTask!.isChecked,
                            );

                            // Mettre à jour la tâche dans la base de données
                            tacheService.update(modifiedTask);
                            fetchTasksList(widget.mariageId);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          'Valider',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
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
                  setState(() {
                    selectedTask = tasksList[indexTache];
                  });
                    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Voulez-vous vraiment supprimer cet élément ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text('Non'),
            ),
            TextButton(
              onPressed: () {
                tacheService.delete(selectedTask!.tacheId ?? '');
                fetchTasksList(widget.mariageId);
                Navigator.of(context).pop(); // Ferme la boîte de dialogue après la suppression
              },
              child: Text('Oui', 
                  style: TextStyle(
                        color: Colors.red,
                      ),
                  ),
            ),
          ],
        );
                },
              );
                })
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
                              
                            final ttache = Tache(
                                tacheId: '',
                                nom: nom,
                                status: status,
                                description: description,
                                date: selectedDate ?? DateTime.now(),
                                mariageId: widget.mariageId,
                              );

                              tacheService.create(ttache);
                              fetchTasksList(widget.mariageId);
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
                            color: Colors.white,
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
)

        );
     
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFFFC8B8B),
            value: 70,
            title: '70%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.grey,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
