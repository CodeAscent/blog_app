import 'package:blog_app/core/common/utils/app_colors.dart';
import 'package:blog_app/features/blog/presentation/pages/home/screens/home_screen.dart';
import 'package:blog_app/features/blog/presentation/pages/newPost/screens/new_post_screen.dart';
import 'package:blog_app/features/blog/presentation/pages/profile/screens/profile_screen.dart';
import 'package:blog_app/features/blog/presentation/pages/search/screens/search_screen.dart';
import 'package:double_back_to_exit/non_web_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens = [
    HomeScreen(),
    SearchScreen(),
    NewPostScreen(),
    Text("messages"),
    ProfileScreen(),
  ];
  List<Widget> _centerBuilds() {
    List<Widget> newList = [];
    for (var item in _buildScreens) {
      newList.add(Center(
        child: item,
      ));
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToExitWidget(
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        doubleBackDuration: Duration(milliseconds: 1700),
        backgroundColor: primaryColor(),
        snackBarMessage: "Press Again to Exit!",
        child: PersistentTabView(
          backgroundColor: Colors.black,
          controller: _controller,
          context,
          screens: _centerBuilds(),
          items: _navBarsItems(),
          navBarStyle: NavBarStyle.style13,
          stateManagement: false,
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
        ),
      ),
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() => [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "Home",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
          inactiveColorSecondary: Colors.purple),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: "Search",
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        title: "Add",
        activeColorPrimary: Colors.blueAccent,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        title: "Messages",
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled),
        title: "Profile",
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
        ),
      ),
    ];
