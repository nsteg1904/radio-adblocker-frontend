import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio_adblocker/screens/radio/main_radio/radio_title.dart';

import '../../../model/radio_station.dart';
import '../../../shared/auto_scrolling_text.dart';

class MainRadio extends StatelessWidget {
  final RadioStation currentRadio;

  const MainRadio({super.key, required this.currentRadio});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Radiotitle(
              currentRadio: currentRadio,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.width * 0.65,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28.0),
              child: Image.network(
                currentRadio.logoUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //Song description of the current Radio
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: AutoScrollingText(
                    text: currentRadio.song.name,
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: AutoScrollingText(
                    text: currentRadio.song.artist,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Color(0xfff7b7b8b),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
