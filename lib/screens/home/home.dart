import 'package:flutter/material.dart';
import 'package:radio_adblocker/screens/home/currentRadio.dart';
import 'package:radio_adblocker/screens/home/filter/filter.dart';
import 'package:radio_adblocker/screens/home/headline.dart';
import 'package:radio_adblocker/screens/home/radioList/radioList.dart';

/// This class represents the home screen.
///
/// It is the first screen the user sees when opening the app.
/// It contains the headline, the filter options, the radio list and the current radio.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // headline (12% of body)
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          child: const Headline(),
        ),
        // filter options (15% of body)
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: const FilterOptions(),
        ),
        // radio list (32% of body)
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.50,
          child: const RadioList(),
        ),
        const CurrentRadio(),
      ],
    );
  }
}
