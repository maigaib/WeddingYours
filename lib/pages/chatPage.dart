import 'package:app_wedding_yours/pages/chatingSection.dart';
import 'package:flutter/material.dart';

const dPink = Color.fromRGBO(253, 139, 139, 1);
const dWhite = Color(0xFFe8f4f2);
const dBlack = Color(0xFF34322f);

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
    onPressed: () {},
    icon: const Icon(
      Icons.arrow_back_outlined,
      color: dBlack,
      size: 30,
    ),
    ),
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
        titleSpacing: 0,//<W
        ),
        body:Column(children: [
          ChatingSection(),
          BottomSection(),
        ],
        ) 
    );
  }
}

//section pour message send
class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 10.0,
      color: dWhite,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 43,
                decoration: const BoxDecoration(
                  color: dPink,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 10.0),
                    Icon(
                      Icons.insert_emoticon,
                      size: 25.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.upload_outlined,
                      size: 25.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.image,
                      size: 25.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 25,
              ),
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: dPink,
                shape: BoxShape.circle,
              ),
              child: const IconButton(
                icon: Icon(
                  Icons.mic_none_sharp,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}