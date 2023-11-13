import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/provider/radioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/home.dart';
import 'package:radio_adblocker/screens/radio/radio.dart';
import 'package:radio_adblocker/screens/settings/settings.dart';
import 'package:radio_adblocker/shared/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Radio Adblocker',
      home: MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});


  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_currentIndex) {
      case 0:
        page = Home();
        break;
      case 1:
        page = RadioScreen();
        break;
      case 2:
        page = Settings();
        break;
      default:
        throw UnimplementedError('no widget for $_currentIndex');
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FilterRadioStationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RadioStationsProvider(),
        ),
      ],
      child: Scaffold(
        backgroundColor: backgroundColor,
        //to ensure the the body starts after the status bar-
        body: SafeArea(
          child: page,
        ),
        bottomNavigationBar:BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.radio),
              label: 'Radio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
