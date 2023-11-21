import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {

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

                          child: Text(
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

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('depenses').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              var depenses = snapshot.data!.docs;

              return ListView.builder(
                itemCount: depenses.length,
                itemBuilder: (context, index) {
                  var depense = depenses[index];
                  var montant = depense['montant'];
                  var description = depense['description'];

                  return ListTile(
                    title: Text(description),
                    subtitle: Text('Cout: $montant'),
                  );
                },
              );
            },
          ),

         
        ],
      ),
    );
  }
}
