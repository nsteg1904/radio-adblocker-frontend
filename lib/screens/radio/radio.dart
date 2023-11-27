import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:radio_adblocker/model/radioStation.dart';

import '../../model/song.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  RadioStation currentRadio = RadioStation.namedParameter(
      id:1,
      name: "1Live",
      streamUrl: "asdf",
      logoUrl: "1Live.png",
      genres: ["EDM", "Techno", "Pop"],
      status: "music",
      song: Song.namedParameter(name: "Losing it", artists: ["FISHER"]));

  @override
  Widget build(BuildContext context) {
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
        //Bild des Radios
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image.asset('assets/${currentRadio.logoUrl}'),
        ),
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
                    currentRadio.song.artists[0],
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
        ),
        Container(
          //Create a line that is visualizing the sound
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Controls(),
        ),
      ],
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    //Make the buttons bigger and in the center of the row
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          iconSize: 80,
          color: Colors.white,
          onPressed: () {},
        ),
        IconButton.outlined(
          icon: const Icon(Icons.play_arrow),
          selectedIcon: const Icon(Icons.pause),
          iconSize: 80,
          color: Colors.white,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          iconSize: 80,
          color: Colors.white,
          onPressed: () {},
        ),
      ],);
  }
}

