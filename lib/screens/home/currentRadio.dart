import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/shared/audioButton.dart';
import 'package:radio_adblocker/shared/colors.dart';

import '../../model/radioStation.dart';
import '../../provider/currentRadioProvider.dart';

class CurrentRadio extends StatefulWidget {
  const CurrentRadio({super.key});

  @override
  State<CurrentRadio> createState() => _CurrentRadioState();
}

class _CurrentRadioState extends State<CurrentRadio> {
  @override
  Widget build(BuildContext context) {
    RadioStation currentRadio = context.watch<CurrentRadioProvider>().currentRadio;
    bool isPlaying = context.watch<CurrentRadioProvider>().isPlaying;

    return Card(
      color: const Color(0xff1d1d30),
      child: ListTile(
        // dense: true,
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
          url: "https://d131.rndfnk.com/ard/wdr/1live/live/mp3/128/stream.mp3?cid=01FBRZTS1K1TCD4KA2YZ1ND8X3&sid=2XyxxkD71majarUcdiEln8KVqD5&token=O5zzKPieNrNpT5ppgEZzveXFuIIey1t9mxLvQqwTC3M&tvf=V9C7UtFSlhdkMTMxLnJuZGZuay5jb20",
          isPlaying: isPlaying,
        ),
      ),
    );
  }
}
