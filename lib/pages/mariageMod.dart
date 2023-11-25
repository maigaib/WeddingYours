import 'package:app_wedding_yours/modeles/mariage.dart';
import 'package:app_wedding_yours/pages/mariages.dart';
//import 'package:app_wedding_yours/repositories/mariagesRepository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_wedding_yours/services/mariagesServices.dart';
class MariageMod extends StatefulWidget {
  final MariagesService mariagesServices;
  final Mariage mariageDetails;
  MariageMod({Key? key, required this.mariageDetails, required this.mariagesServices}) : super(key: key);

  @override
  State<MariageMod> createState() => _MariageModState();
}

class _MariageModState extends State<MariageMod> {
  final _formkey = GlobalKey<FormState>();
  //final MariagesRepository mariagesRepository = MariagesRepository(); // Assurez-vous d'utiliser le nom correct de votre classe

  final  monsieurNameController = TextEditingController();
  final  madameNameController = TextEditingController();
  final  lieuNameController = TextEditingController();
  @override
  void dispose(){
    super.dispose();
    monsieurNameController.dispose();
    madameNameController.dispose();
    lieuNameController.dispose();
  }
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

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    monsieurNameController.text = widget.mariageDetails.monsieur;
    madameNameController.text = widget.mariageDetails.madame;
    lieuNameController.text = widget.mariageDetails.lieu;
    // Initialiser la date si elle est disponible
  //if (widget.mariageDetails.date != null) {
    selectedDate = widget.mariageDetails.date;
 // }

  // Initialiser l'image si elle est disponible
 // if (widget.mariageDetails.photo != null) {
    imagePath = widget.mariageDetails.photo;
  //}
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60),
            Image.asset("assets/images/LogoV.png"),
            const SizedBox(height: 40),

            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), // Coin supérieur gauche
                  topRight: Radius.circular(40), // Coin supérieur droit
                ),
              ),
              child:Form(
                 key: _formkey,
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
                          child: Center(
                            child:Text('Modification Mariage',
                            style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                            ),
                          ) 
                        ),
                            const SizedBox(height: 30),

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
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
                            controller: monsieurNameController,
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
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
                            controller: madameNameController,
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
                              labelText: 'Lieu',
                              hintText: 'Lieu',
                            ),
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Veillez complètez le champ";
                              }
                              return null;
                            },
                            controller: lieuNameController,
                          ),
                        ),
                      ),
                      
                       Container(
                        width: 300, // Largeur du bouton
                        height: 50,
                        margin: const EdgeInsets.only(top: 8, bottom: 10), // Marge supérieure
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

                      const SizedBox(height: 6),
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
                          onPressed: () async {
                              // Mettre à jour les propriétés du mariage avec les nouvelles valeurs
                              widget.mariageDetails.monsieur = monsieurNameController.text;
                              widget.mariageDetails.madame = madameNameController.text;
                              widget.mariageDetails.lieu = lieuNameController.text;
                              widget.mariageDetails.date = selectedDate!;
                              widget.mariageDetails.photo = imagePath!;

                              // Appeler la méthode de modification dans le service
                              await widget.mariagesServices.updateMariage(widget.mariageDetails);
                                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Envoi en cours ..."))
                                );
                                FocusScope.of(context).requestFocus(FocusNode());
                            Navigator.pop(
                              context,
                              MaterialPageRoute(builder: (context) => Mariages()),
                            );
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
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
            )
          ],
        ),
    ),
    );
  }
}