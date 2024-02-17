import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/model/radio_station.dart';
import '../../../shared/auto_scrolling_text.dart';

import 'controls.dart';

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
    RadioStation? currentRadio = Provider.of<RadioStation?>(context);
    //Holds all seperate Elements of this Screen
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //Title of the current Radio
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          child: Center(
            child: Text(
              currentRadio!.name,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          ),
        ),
        //Image of the current Radio
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image.network(currentRadio.logoUrl, scale: 0.5),
        ),
        //Song description of the current Radio
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Column(
              children: [
                 AutoScrollingText(
                    text: currentRadio.song.name,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                AutoScrollingText(
                    text: currentRadio.song.artist,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
        ),
        //Control Buttons (Play, forward, backwards)
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: const Controls(),
        ),
      ],
    );
  }
}



