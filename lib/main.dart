import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/provider/radioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/home.dart';
import 'package:radio_adblocker/screens/navbar.dart';
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

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    //initialize all Provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FilterRadioStationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RadioStationsProvider(),
        ),
      ],
      child: const Scaffold(
        backgroundColor: backgroundColor,
        //to ensure the the body starts after the status bar-
        body: SafeArea(
          child: Home(),
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
      ),
    );
  }
}
