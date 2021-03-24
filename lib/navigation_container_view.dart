import 'package:flutter/material.dart';
import 'package:flutter_animation/cart_screen.dart';
import 'package:flutter_animation/drawer_controller.dart';
import 'package:flutter_animation/drawer_index.dart';
import 'package:flutter_animation/home_screen.dart';

class NavigationContainerView extends StatefulWidget {
  @override
  _NavigationContainerViewState createState() =>
      _NavigationContainerViewState();
}

class _NavigationContainerViewState extends State<NavigationContainerView> {
  Widget currentScreen;
  DrawerIndex drawerIndex;
  IconData menuIcon = Icons.menu;
  @override
  void initState() {
    currentScreen = HomeView();
    drawerIndex = DrawerIndex.HOME;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawerController(
      content: currentScreen,
      currentIndex: drawerIndex,
      drawerAnimationDuration: 200,
      onItemTapped: (item) {
        if (item.drawerIndex == DrawerIndex.HOME) {
          setState(() {
            currentScreen = HomeView();
            drawerIndex = item.drawerIndex;
          });
        } else if (item.drawerIndex == DrawerIndex.CART) {
          setState(() {
            currentScreen = CartScreen();
            drawerIndex = item.drawerIndex;
          });
        } else if (item.drawerIndex == DrawerIndex.TO_REVIEW) {}
      },
      drawerWidth: MediaQuery.of(context).size.width * 0.75,
      drawerToggleCallback: (isOpen) {},
    );
  }
}
