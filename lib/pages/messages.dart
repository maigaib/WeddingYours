import 'package:app_wedding_yours/pages/chatPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const dPink = Color.fromRGBO(253, 139, 139, 1);
const dWhite = Color(0xFFe8f4f2);
const dBlack = Color(0xFF34322f);
class Messages extends StatefulWidget {
  const Messages({super.key});
  
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
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
            floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: dPink,
        child: const Icon(
          Icons.edit,
          size: 20,
        ),
      ),

      body: Column(
          children: [
           // MenuSection(),
            FavoriteSection(),
            Expanded(
              child: MessageSection(),
            )
          ],
        ),

    );
  }
}


class FavoriteSection extends StatelessWidget {
  FavoriteSection({Key? key}) : super(key: key);
  final List favoriteContacts = [
    {
      'name': 'Alla',
      'profile': 'assets/images/b5.png',
    },
    
    {
      'name': 'Sory',
      'profile': 'assets/images/b2.png',
    },
     {
      'name': 'Nana',
      'profile': 'assets/images/b1.png',
    },
     {
      'name': 'Mariam',
      'profile': 'assets/images/b3.png',
    },
     {
      'name': 'Fifi',
      'profile': 'assets/images/b4.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: dBlack,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          color: dPink,
          // borderRadius: BorderRadius.only(
          //   topRight: Radius.circular(40),
          //   topLeft: Radius.circular(40),
          // ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Prestataires Favories",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: null,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: favoriteContacts.map((favorite) {
                  return Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                            color: dWhite,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(favorite['profile']),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          favorite['name'],
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//messages 
class MessageSection extends StatelessWidget {
  MessageSection({Key? key}) : super(key: key);
  final List messages = [
    {
      'senderProfile': 'assets/images/b5.png',
      'senderName': 'Nara',
      'message': 'Salut comment allez vous',
      'unRead': 0,
      'date': '16:35',
    },
  
    {
      'senderProfile': 'assets/images/b2.png',
      'senderName': 'Sory',
      'message': 'çava je peux aider',
      'unRead': 3,
      'date': '07:31',
    },
    {
      'senderProfile': 'assets/images/b3.png',
      'senderName': 'Ly',
      'message': 'Disponible ce mois',
      'unRead': 0,
      'date': '07:31',
    },
    {
      'senderProfile': 'assets/images/b2.png',
      'senderName': 'Sory',
      'message': 'Salut ...',
      'unRead': 3,
      'date': '07:31',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: messages.map((message) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatPage(),
                ),
              );
            },
            splashColor: dPink,
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 10, top: 15),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 23),
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(message['senderProfile']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    message['senderName'],
                                    style: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Wrap(children: [
                                    Text(
                                      message['message'],
                                      style: GoogleFonts.inter(
                                        color: Colors.black87,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(message['date']),
                                message['unRead'] != 0
                                    ? Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: dPink,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          message['unRead'].toString(),
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          color: Colors.grey[400],
                          height: 0.5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}