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
                "Alla Burda",
                style: GoogleFonts.inter(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Was online 56 seconde ago",
                style: GoogleFonts.inter(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 45),
              TextMessage(
                message: "Months on ye at by esteem",
                date: "17:19",
                senderProfile: senderProfile,
                isReceiver: 1,
                isDirect: 0,
              ),
             
              const ImageMessage(
                image: 'assets/images/b1.png',
                date: "17:09",
                description: "Least their she you now above going stand forth",
              ),
             
              TextMessage(
                message: "Under as seems we me stuff",
                date: "16:53",
                senderProfile: senderProfile,
                isReceiver: 0,
                isDirect: 0,
              ),
              TextMessage(
                message: "Next it draw in draw much bred",
                date: "16:50",
                senderProfile: senderProfile,
                isReceiver: 0,
                isDirect: 1,
              ),
              TextMessage(
                message: "Sure that that way gave",
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