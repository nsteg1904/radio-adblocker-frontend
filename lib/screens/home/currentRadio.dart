import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/shared/audioButton.dart';
import 'package:radio_adblocker/shared/colors.dart';

import '../../model/radioStation.dart';
import '../../provider/currentRadioProvider.dart';

class CurrentRadio extends StatelessWidget {
  const CurrentRadio({super.key});

  @override
  Widget build(BuildContext context) {
    RadioStation currentRadio = context.watch<CurrentRadioProvider>().currentRadio;

    return Card(
      color: const Color(0xff1d1d30),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/${currentRadio.logoUrl}',
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
          currentRadio.song.artists[0],
          style: const TextStyle(color: defaultFontColor),
        ),
        trailing: AudioButton(
          size: 1.0,
        ),
      ),
    );
  }
}
