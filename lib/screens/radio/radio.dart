import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:radio_adblocker/model/radioStation.dart';

import '../../model/song.dart';
import '../../shared/colors.dart';
import '../../shared/radioStreamControlButton.dart';

///Covers the whole screen and shows the current Radio with all its information and controls.
///
///Displays the current Radio with its name, logo, songname, artistname and controls.
class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  //TestData, needs to be substituted with Api Data
  RadioStation currentRadio = RadioStation.namedParameter(
      id:1,
      name: "1Live",
      streamUrl: "asdf",
      logoUrl: "1Live.png",
      genres: ["EDM", "Techno", "Pop"],
      status: "music",
      song: Song.namedParameter(name: "Losing it", artist: "FISHER"));

  @override
  Widget build(BuildContext context) {
    //Holds all seperate Elements of this Screen
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //Überschrift des Radios
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          child: Center(
            child: Text(
              currentRadio.name,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          ),
        ),
        //Image of the current Radio
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image.asset('assets/${currentRadio.logoUrl}'),
        ),
        //Song description of the current Radio
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Column(
              children: [
                Text(
                    currentRadio.song.name,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(
                    currentRadio.song.artist[0],
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
        ),
        //TODO: Create a line that is visualizing the sound
        Container(
          //Create a line that is visualizing the sound
        ),
        //Control Buttons (Play, forward, backwards)
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Controls(),
        ),
      ],
    );
  }
}

///Displays the control buttons to navigate between Radios and Play / Pause.
class Controls extends StatefulWidget {
  static const double size = 2;
  const Controls({super.key});

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    //Make the buttons bigger and in the center of the row
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 27.0 * Controls.size, // to scale Widget size
          backgroundColor: backgroundColor,
          child: IconButton(
            icon: const Icon(Icons.skip_previous),
            iconSize: 35 * Controls.size,
            color: Colors.white,
            onPressed: () {},
          )
        ),
        const RadioStreamControlButton(
          //gives the size of widget as a parameter to scale the widget
          size: Controls.size,
        ),
        CircleAvatar(
            radius: 27.0 * Controls.size, // to scale Widget size
            backgroundColor: backgroundColor,
            child: IconButton(
              icon: const Icon(Icons.skip_next,),
              iconSize: 35 * Controls.size,
              color: Colors.white,
              onPressed: () {},
            )
        ),
      ],);
  }
}

