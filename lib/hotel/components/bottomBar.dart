import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tour/hotel/views/accountPage.dart';
import 'package:tour/hotel/views/first.dart';
import 'package:tour/hotel//views/searchPage.dart';




class CusBottomNavigationBar extends StatefulWidget {
  static late BuildContext context;

  const CusBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CusBottomNavigationBar> createState() => _CusBottomNavigationBarState();
}

class _CusBottomNavigationBarState extends State<CusBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    CusBottomNavigationBar.context=context;
    PersistentTabController _controller;
    List<Widget> _buildScreens() {
      return const [FirstPage(),SearchPage(),AccountPage()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: "Home",
          activeColorPrimary:Colors.brown,
          inactiveColorPrimary: Colors.brown,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.search),
          title: "Search",
          activeColorPrimary:Colors.brown,
          inactiveColorPrimary: Colors.brown,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.profile_circled),
          title: "Account",
          activeColorPrimary:Colors.brown,
          inactiveColorPrimary: Colors.brown,
        ),

      ];
    }

    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
      NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
