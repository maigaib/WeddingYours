import 'package:app_wedding_yours/pages/accueil.dart';
import 'package:app_wedding_yours/pages/connexion.dart';
import 'package:flutter/material.dart';
import 'package:app_wedding_yours/pages/invites.dart';
import 'package:app_wedding_yours/pages/mariages.dart';
import 'package:app_wedding_yours/pages/messages.dart';
import 'package:app_wedding_yours/pages/prestataires.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
    setCurrentIndex(int index){
      setState(() {
        _currentIndex = index;
      });
    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("Accueil"),
        // ),
        body: [
          Connexion(),
          Accueil(),
          Messages(),
          Mariages(),
          Invites(),
          Prestataires()
        ][_currentIndex],
        bottomNavigationBar: _currentIndex == 0
            ? null
         :BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setCurrentIndex(index) ,
            selectedItemColor: Color.fromRGBO(253, 139, 139, 1),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Accueil' 
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                label: 'Message' 
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Mariage' 
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Invites' 
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Prestataires' 
              )
            ]
            ),
        ),
    );
  }
}