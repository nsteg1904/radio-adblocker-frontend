import 'package:flutter/material.dart';
import 'package:radio_adblocker/screens/home/current_radio.dart';
import 'package:radio_adblocker/screens/home/filter/filter.dart';
import 'package:radio_adblocker/screens/home/headline.dart';
import 'package:radio_adblocker/screens/home/radio_list/radio_list.dart';

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
    return const Column(
        children: [
          SizedBox(
            height: 80,
            child: Headline(),
          ),
          SizedBox(
            height: 105,
            child: FilterOptions(),
          ),
          Expanded(
            child: RadioList(),
          ),
          CurrentRadio(),
        ],
      );
  }
}
