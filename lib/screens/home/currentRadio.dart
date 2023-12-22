import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/shared/auto_scrolling_text.dart';
import 'package:radio_adblocker/shared/radioStreamControlButton.dart';
import 'package:radio_adblocker/shared/colors.dart';

import '../../model/radioStation.dart';
import '../../shared/custom_list_tile.dart';

/// This class represents the radio station that is currently playing.
///
/// It is used in [Home] to display the current radio station.
class CurrentRadio extends StatelessWidget {
  const CurrentRadio({super.key});

  @override
  Widget build(BuildContext context) {
    RadioStation? currentRadio = Provider.of<RadioStation?>(context);

    return Card(
      margin: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 5.0),
      color: const Color(0xff1d1d30),
      child: currentRadio != null
          ? CustomListTile(
              padding: 14,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  currentRadio.logoUrl,
                  fit: BoxFit.cover,
                ),
              ),
              title: AutoScrollingText(
                text: currentRadio.song.name,
                style: const TextStyle(
                  color: defaultFontColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: AutoScrollingText(
                text: currentRadio.song.artist,
                style: const TextStyle(
                  color: defaultFontColor,
                  fontSize: 16.0,
                ),
              ),
              trailing: const RadioStreamControlButton(
                size: 1.0,
              ),
            )
          : const Text("Kein Radio ausgewählt"),
    );
  }
}
