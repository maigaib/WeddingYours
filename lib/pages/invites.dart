import 'package:flutter/material.dart';
class Invites extends StatefulWidget {
  const Invites({super.key});

  @override
  State<Invites> createState() => _InvitesState();
}

class _InvitesState extends State<Invites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
    //     leading: IconButton(
    // onPressed: () {},
    // icon: const Icon(
    //   Icons.arrow_back_outlined,
    //   color: dBlack,
    //   size: 30,
    // ),
    // ),
        title : Image.asset("assets/images/LogoMini.png"),
        //backgroundColor: Color.fromRGBO(253, 139, 139, 1),
        backgroundColor: Colors.white,
        //elevation: 50.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu,
            color: Color.fromRGBO(253, 139, 139, 1),
            ),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ), //IconButton
         //IconButton
        ], 
        //titleSpacing: 0,//<W
        ),
    );
  }
}