import 'package:flutter/material.dart';
import 'package:yomikata/pages/addDeckPage.dart';
import './pages/profilePage.dart';
import './pages/gameConfigPage.dart';
import 'mongoDb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Router(),
    );
  }
}

class Router extends StatefulWidget {
  const Router({Key? key}) : super(key: key);

  @override
  State<Router> createState() => _RouterState();
}

class _RouterState extends State<Router> {

  int _selectedItem = 0;

  static const List<Widget> _pagesList = <Widget>[
    GameConfigPage(),
    AddDeckPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagesList.elementAt(_selectedItem),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff670D0D),
        onTap: _onItemTapped,
        selectedItemColor: Color(0xffd46666),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedItem,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.filter_none,
              ),
              label: "Decks"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile"
          ),
        ],
      ),
    );
  }
}
