import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class AudioButton extends StatefulWidget {
  const AudioButton({super.key});

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  final player = AudioPlayer();
  bool isPlaying = false;

  Future<void> playAudioFromUrl(String url) async {
    await player.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 27.0,
      backgroundColor: playButtonBackground,
      child: IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: () {
          if (isPlaying) {
                player.stop();
          } else {
            playAudioFromUrl(
                "https://d131.rndfnk.com/ard/wdr/1live/live/mp3/128/stream.mp3?cid=01FBRZTS1K1TCD4KA2YZ1ND8X3&sid=2XyxxkD71majarUcdiEln8KVqD5&token=O5zzKPieNrNpT5ppgEZzveXFuIIey1t9mxLvQqwTC3M&tvf=V9C7UtFSlhdkMTMxLnJuZGZuay5jb20");
          }
          setState(() => isPlaying = !isPlaying);
        },
        icon: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: playButton,
          size: 35.0,
        ),
      ),
    );
  }
}
