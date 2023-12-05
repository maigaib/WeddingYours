import 'package:app_wedding_yours/modeles/imageMessage.dart';
import 'package:app_wedding_yours/modeles/textMessage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/// chating section 
class ChatingSection extends StatelessWidget {
  final String senderProfile = 'assets/images/a3.png';
  final String receiverProfile = 'assets/images/b1.png';
  const ChatingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        //height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topRight: Radius.circular(40),
          //   topLeft: Radius.circular(40),
          // ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text(
                "Alla Baba",
                style: GoogleFonts.inter(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "La date du 05",
                style: GoogleFonts.inter(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 45),
              TextMessage(
                message: "Mois prochaine ok",
                date: "17:19",
                senderProfile: senderProfile,
                isReceiver: 1,
                isDirect: 0,
              ),
             
              const ImageMessage(
                image: 'assets/images/b1.png',
                date: "17:09",
                description: "Pour une semaine",
              ),
             
              TextMessage(
                message: "30 000  parfait",
                date: "16:53",
                senderProfile: senderProfile,
                isReceiver: 0,
                isDirect: 0,
              ),
              TextMessage(
                message: "rendez vous lundi",
                date: "16:50",
                senderProfile: senderProfile,
                isReceiver: 0,
                isDirect: 1,
              ),
              TextMessage(
                message: "avec plaisir madame",
                date: "16:48",
                senderProfile: senderProfile,
                isReceiver: 1,
                isDirect: 0,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}