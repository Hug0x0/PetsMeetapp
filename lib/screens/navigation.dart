import 'package:flutter/material.dart';
import 'package:pets_meet/screens/Home.dart';
import 'package:pets_meet/screens/calendar.dart';
import 'package:pets_meet/screens/maps.dart';
import 'package:pets_meet/screens/message.dart';
import 'package:pets_meet/screens/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Navigation(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class Navigation extends StatefulWidget {
  Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

/// This is the private State class that goes with Home.
class _NavigationState extends State<Navigation> {
  int _selectedIndex = 2;
  List<Widget> _widgetOptions = <Widget>[
    Maps(),
    Calendar(),
    Home(),
    Message(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Calendrier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Réglage',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
