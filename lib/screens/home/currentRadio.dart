import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/shared/radioStreamControlButton.dart';
import 'package:radio_adblocker/shared/colors.dart';

import '../../model/radioStation.dart';

/// This class represents the radio station that is currently playing.
///
/// It is used in [Home] to display the current radio station.
class CurrentRadio extends StatelessWidget {
  const CurrentRadio({super.key});

  @override
  Widget build(BuildContext context) {
    RadioStation? currentRadio = Provider.of<RadioStation?>(context);

    return Card(
      color: const Color(0xff1d1d30),
      child: currentRadio != null
          ? ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(currentRadio.logoUrl,
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                currentRadio.song.name,
                style: const TextStyle(color: defaultFontColor),
              ),
              subtitle: Text(
                currentRadio.song.artist,
                style: const TextStyle(color: defaultFontColor),
              ),
              trailing: const RadioStreamControlButton(
                size: 1.0,
              ),
            )
          : const Text("Kein Radio ausgewählt"),
    );
  }
}
