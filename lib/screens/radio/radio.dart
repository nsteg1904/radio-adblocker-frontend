import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/model/radio_station.dart';
import 'package:radio_adblocker/screens/radio/main_radio/main_radio.dart';
import 'package:radio_adblocker/shared/colors.dart';

import 'controlls/controls.dart';

///Covers the whole screen and shows the current Radio with all its information and controls.
///
///Displays the current Radio with its name, logo, songname, artistname and controls.
class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      RadioStation? currentRadio = Provider.of<RadioStation?>(context);

      return currentRadio != null ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          SizedBox(
            height: 430,
            child: MainRadio(
              currentRadio: currentRadio,
            ),
          ),
          const SizedBox(
            child: Controls(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          )
        ],
      ) : const Placeholder();
    } catch (e) {
      return const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlertDialog(
              backgroundColor: backgroundColor,
              title: Text('Error', style: TextStyle(color: defaultFontColor)),
              content: Text(
                  'Ein Fehler ist aufgetreten.\nBitte verbinden sie sich mit dem Internet.',
                  style: TextStyle(color: defaultFontColor)),
            ),
          ]);
    }
  }
}
