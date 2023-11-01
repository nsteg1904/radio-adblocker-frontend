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
      name: "1Live",
      url: "asdf",
      image: "1Live.png",
      genres: ["EDM", "Techno", "Pop"],
      status: "music",
      song: Song.namedParameter(name: "Losing it", artists: ["FISHER"]));

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Image.asset('assets/${currentRadio.image}'),
        ),
        Container(
          color: Colors.black,
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
      ],
    );
  }
}
