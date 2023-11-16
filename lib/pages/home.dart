import 'package:app_wedding_yours/pages/accueil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter/services.dart' show rootBundle;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          elevation: 2,
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
        body: SingleChildScrollView(
    child:Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                    trailing: <Widget>[
                      Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          isSelected: isDark,
                          onPressed: () {
                            setState(() {
                              isDark = !isDark;
                            });
                          },
                          icon: const Icon(Icons.wb_sunny_outlined),
                          selectedIcon: const Icon(Icons.brightness_2_outlined),
                        ),
                      )
                    ],
                  );
                },
                suggestionsBuilder: (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Categories",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),
             Stack(
  children: [
    Container(
      width: 153,
      height: 2063,
      decoration: ShapeDecoration(
        color: Color(0x87FFB6B6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(8),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color.fromARGB(60, 237, 190, 190),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
    ),
    Positioned(
      top: 20,
      left: 20,
      child: SizedBox(
        width: 97,
        height: 25,
        child: Text(
          'Photo',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    ),
    
    Padding(
  padding: const EdgeInsets.only(top: 40, left: 55),
  child: Center(
    child: Container(
      width: 234,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/photo11.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 6,
            child: Icon(
              Icons.arrow_circle_right_outlined, // Remplacez par l'icône que vous souhaitez utiliser
              color: Color.fromRGBO(172, 21, 21, 1),
              size: 30.0,
            ),
          ),
        ],
      ),
    ),
  ),
),
//=====================================================titre 2
SizedBox(height: 10),
const Positioned(
      top: 200,
      left: 20,
      child: SizedBox(
        width: 97,
        height: 25,
        child: Text(
          'Decoration',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    ),
    
    Padding(
  padding: const EdgeInsets.only(top: 230, left: 55),
  child: Center(
    child: Container(
      width: 234,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/deco1.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 6,
            child: InkWell(
              onTap: () {
                // Navigation vers une autre page ici
                Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
              },
            child: Icon(
              Icons.arrow_circle_right_outlined, // Remplacez par l'icône que vous souhaitez utiliser
              color: Color.fromRGBO(172, 21, 21, 1),
              size: 30.0,
            ),
          ),
          )
        ],
      ),
    ),
  ),
),

//=====================================================titre 3
const Positioned(
      top: 400,
      left: 20,
      child: SizedBox(
        width: 97,
        height: 25,
        child: Text(
          'Robes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    ),
SizedBox(height: 10),
    
    Padding(
  padding: const EdgeInsets.only(top: 420, left: 55),
  child: Center(
    child: Container(
      width: 234,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/robbe 1.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 6,
            child: InkWell(
              onTap: () {
                // Navigation vers une autre page ici
                Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
              },
            child: Icon(
              Icons.arrow_circle_right_outlined, // Remplacez par l'icône que vous souhaitez utiliser
              color: Color.fromRGBO(172, 21, 21, 1),
              size: 30.0,
            ),
          ),
          )
        ],
      ),
    ),
  ),
),

// //================================================= 4 
 const Positioned(
      top: 600,
      left: 20,
      child: SizedBox(
        width: 120,
        height: 25,
        child: Text(
          'Restauration',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    ),
SizedBox(height: 10),
    
    Padding(
  padding: const EdgeInsets.only(top: 625, left: 55),
  child: Center(
    child: Container(
      width: 234,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/resto2.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 6,
            child: InkWell(
              onTap: () {
                // Navigation vers une autre page ici
                Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
              },
            child: Icon(
              Icons.arrow_circle_right_outlined, // Remplacez par l'icône que vous souhaitez utiliser
              color: Color.fromRGBO(172, 21, 21, 1),
              size: 30.0,
            ),
          ),
          )
        ],
      ),
    ),
  ),
),

// //=====================================================titre 5
const Positioned(
      top: 800,
      left: 20,
      child: SizedBox(
        width: 97,
        height: 25,
        child: Text(
          'Beaute',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    ),
SizedBox(height: 10),
    
    Padding(
  padding: const EdgeInsets.only(top: 820, left: 55),
  child: Center(
    child: Container(
      width: 234,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/makeup1.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 6,
            child: InkWell(
              onTap: () {
                // Navigation vers une autre page ici
                Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
              },
            child: Icon(
              Icons.arrow_circle_right_outlined, // Remplacez par l'icône que vous souhaitez utiliser
              color: Color.fromRGBO(172, 21, 21, 1),
              size: 30.0,
            ),
          ),
          )
        ],
      ),
    ),
  ),
),

// //================================================= 6  
const Positioned(
      top: 1000,
      left: 20,
      child: SizedBox(
        width: 97,
        height: 25,
        child: Text(
          'Bijoux',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    ),
SizedBox(height: 10),
    
    Padding(
  padding: const EdgeInsets.only(top: 1020, left: 55),
  child: Center(
    child: Container(
      width: 234,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/bijouxM.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 6,
            child: InkWell(
              onTap: () {
                // Navigation vers une autre page ici
                Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
              },
            child: Icon(
              Icons.arrow_circle_right_outlined, // Remplacez par l'icône que vous souhaitez utiliser
              color: Color.fromRGBO(172, 21, 21, 1),
              size: 30.0,
            ),
          ),
          )
        ],
      ),
    ),
  ),
),

// //=====================================================titre 7
const Positioned(
      top: 1200,
      left: 20,
      child: SizedBox(
        width: 97,
        height: 25,
        child: Text(
          'Musique',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    ),
SizedBox(height: 10),
    
    Padding(
  padding: const EdgeInsets.only(top: 1220, left: 55),
  child: Center(
    child: Container(
      width: 234,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/dj1 1.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 6,
            child: InkWell(
              onTap: () {
                // Navigation vers une autre page ici
                Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
              },
            child: Icon(
              Icons.arrow_circle_right_outlined, // Remplacez par l'icône que vous souhaitez utiliser
              color: Color.fromRGBO(172, 21, 21, 1),
              size: 30.0,
            ),
          ),
          )
        ],
      ),
    ),
  ),
),

// //================================================= 8 
const Positioned(
      top: 1400,
      left: 20,
      child: SizedBox(
        width: 97,
        height: 25,
        child: Text(
          'Location',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    ),
SizedBox(height: 10),
    
    Padding(
  padding: const EdgeInsets.only(top: 1420, left: 55),
  child: Center(
    child: Container(
      width: 234,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/location2.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 6,
            child: InkWell(
              onTap: () {
                // Navigation vers une autre page ici
                Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
              },
            child: Icon(
              Icons.arrow_circle_right_outlined, // Remplacez par l'icône que vous souhaitez utiliser
              color: Color.fromRGBO(172, 21, 21, 1),
              size: 30.0,
            ),
          ),
          )
        ],
      ),
    ),
  ),
),

//=====================================================titre 9
const Positioned(
      top: 1600,
      left: 20,
      child: SizedBox(
        width: 97,
        height: 25,
        child: Text(
          'Hotels',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    ),
SizedBox(height: 10),
    
    Padding(
  padding: const EdgeInsets.only(top: 1620, left: 55),
  child: Center(
    child: Container(
      width: 234,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/hotels.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 6,
            child: InkWell(
              onTap: () {
                // Navigation vers une autre page ici
                Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
              },
            child: Icon(
              Icons.arrow_circle_right_outlined, // Remplacez par l'icône que vous souhaitez utiliser
              color: Color.fromRGBO(172, 21, 21, 1),
              size: 30.0,
            ),
          ),
          )
        ],
      ),
    ),
  ),
),
 
 //================================================= 10   
  const Positioned(
      top: 1800,
      left: 20,
      child: SizedBox(
        width: 127,
        height: 25,
        child: Text(
          'Accessoires',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    ),
SizedBox(height: 10),
    
    Padding(
  padding: const EdgeInsets.only(top: 1820, left: 55),
  child: Center(
    child: Container(
      width: 234,
      height: 140,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/accessoires1.png'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            right: 6,
            child: InkWell(
              onTap: () {
                // Navigation vers une autre page ici
                Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
              },
            child: const Icon(
              Icons.arrow_circle_right_outlined, // Remplacez par l'icône que vous souhaitez utiliser
              color: Color.fromRGBO(172, 21, 21, 1),
              size: 30.0,
            ),
          ),
          )
        ],
      )
             ),
             ),
             )
             ],
          ),
        ]
        ),
      ),
      )
    )
    );
  }
}
