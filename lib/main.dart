

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/provider/currentRadioProvider.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/provider/radioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/home.dart';
import 'package:radio_adblocker/screens/radio/radio.dart';
import 'package:radio_adblocker/screens/settings/settings.dart';
import 'package:radio_adblocker/services/radioListService.dart';
import 'package:radio_adblocker/shared/colors.dart';

import 'model/radioStation.dart';
import 'model/song.dart';

Future<void> main() async {
  RadioListService radioListService = RadioListService();
  await radioListService.requestRadioList(1);
  // final asdf = await radioListService.getRadioList();
  // print(asdf);
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
  int _selectedIndex = 0;
  final Color _selectedColor = selectedElementColor;
  final Color _unselectedColor = unSelectedElementColor;
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {


    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = const Home();
        break;
      case 1:
        page = const RadioScreen();
        break;
      case 2:
        page = const Settings();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FilterRadioStationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RadioStationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentRadioProvider(RadioStation.namedParameter(id:1,name: "Bremen Next", streamUrl: "asdf", logoUrl: "bremen_next.png", genres: ["EDM", "Techno", "Pop"], status: "add", song: Song.namedParameter(name: "Losing it",artists: ["FISHER"]), isFavorite: true)),
        ),
      ],
      child: Scaffold(
        backgroundColor: backgroundColor,
        //to ensure the the body starts after the status bar-
        body: SafeArea(
          child: page,
        ),
        bottomNavigationBar:BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: backgroundColor,

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

          selectedItemColor: _selectedColor,
          unselectedItemColor: _unselectedColor,
        ),
      ),
    );
  }
}
