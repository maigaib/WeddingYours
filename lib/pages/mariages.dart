import 'package:app_wedding_yours/pages/mariageAdd.dart';
import 'package:app_wedding_yours/pages/mariage_content.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_wedding_yours/services/mariagesServices.dart';
class Mariages extends StatefulWidget {
  const Mariages({Key? key}) : super(key: key);

  @override
  State<Mariages> createState() => _MariagesState();
}

class _MariagesState extends State<Mariages> {
  late Stream<QuerySnapshot> mariagesStream;
  final CollectionReference mariagesCollection =
      FirebaseFirestore.instance.collection('mariages');
    final MariagesService mariagesServices = MariagesService(); // Assurez-vous que cette ligne est présente
  @override
  void initState() {
    super.initState();
    mariagesStream = mariagesCollection.snapshots();
  }

  Widget buildCardM(String imagePath, String title) {
    return Container(
      // Utilisez un ternaire pour ajuster la largeur du Container en fonction du nombre de mariages dans la ligne
                        width: MediaQuery.of(context).size.width / 2,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 120,
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.remove_red_eye),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Image.asset("assets/images/LogoMini.png"),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color.fromRGBO(253, 139, 139, 1),
            ),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ),
        ],
      ),
      body:Padding(
  padding: const EdgeInsets.only(top: 20),
  child: SingleChildScrollView(
    child: StreamBuilder<QuerySnapshot>(
      stream: mariagesStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final mariages = snapshot.data!.docs;

        // Diviser la liste de mariages en listes de deux éléments
        List<List<DocumentSnapshot>> dividedList = [];
        for (int i = 0; i < mariages.length; i += 2) {
          int end = (i + 2 <= mariages.length) ? i + 2 : mariages.length;
          dividedList.add(mariages.sublist(i, end));
        }

        // Afficher chaque paire de mariages dans une nouvelle ligne
        return Column(
          children: dividedList.map((rowMariages) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                for (var mariage in rowMariages)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MariageContent(mariageId: mariage.id, service: mariagesServices),
                        ),
                      );
                    },
                    child: Container(
                      height: 180,
                      child: buildCardM(
                          mariage['photo'], mariage['monsieur'] + ' & ' + mariage['madame']),
                    ),
                  ),
              ],
            );
          }).toList(),
        );
      },
    ),
  ),
),


      floatingActionButton: Container(
        width: 300,
        height: 40,
        margin: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MariageAdd()),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 24,
              ),
              SizedBox(width: 10),
              Text(
                'Ajouter',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
