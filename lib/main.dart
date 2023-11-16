import 'package:app_wedding_yours/pages/invites.dart';
import 'package:app_wedding_yours/pages/mariages.dart';
import 'package:app_wedding_yours/pages/prestataires.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_wedding_yours/pages/home.dart';
import 'package:app_wedding_yours/pages/messages.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return MaterialApp(
      home: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    Home(),
    Messages(),
    Mariages(),
    Invites(),
    Prestataires()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: "Accueil",
      activeColorPrimary: const Color.fromRGBO(253, 139, 139, 1),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.mail),
      title: "Messages",
      activeColorPrimary: const Color.fromRGBO(253, 139, 139, 1),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.heart_circle_fill),
      title: "Mariages",
      activeColorPrimary: const Color.fromRGBO(253, 139, 139, 1),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.person_2),
      title: "Invites",
      activeColorPrimary: const Color.fromRGBO(253, 139, 139, 1),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.briefcase),
      title: "Prestataires",
      activeColorPrimary: const Color.fromRGBO(253, 139, 139, 1),
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
