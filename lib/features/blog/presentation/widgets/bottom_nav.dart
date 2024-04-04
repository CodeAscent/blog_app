import 'package:blog_app/features/blog/presentation/pages/home_screen.dart';
import 'package:blog_app/features/blog/presentation/pages/newPost/screens/new_post_screen.dart';
import 'package:blog_app/features/blog/presentation/pages/profile_screen.dart';
import 'package:blog_app/features/blog/presentation/pages/search_screen.dart';
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
    Text("screen4"),
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
      body: PersistentTabView(
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
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
        ),
      ),
    ];
