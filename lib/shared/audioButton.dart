import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/currentRadioProvider.dart';
import 'colors.dart';

class AudioButton extends StatefulWidget {
  final String url;
  final bool isPlaying;

  const AudioButton({super.key, required this.url, required this.isPlaying});

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  @override
  Widget build(BuildContext context) {
    final currentRadioProvider = context.read<CurrentRadioProvider>();

    Future<void> playAudioFromUrl(String url) async {
      await currentRadioProvider.audioPlayer.play(UrlSource(url));
    }

    return CircleAvatar(
      radius: 27.0,
      backgroundColor: playButtonBackground,
      child: IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: () {
          widget.isPlaying
              ? currentRadioProvider.audioPlayer.stop()
              : playAudioFromUrl(widget.url);

          currentRadioProvider.setIsPlaying(isPlaying: !widget.isPlaying);
        },
        icon: Icon(
          widget.isPlaying ? Icons.pause : Icons.play_arrow,
          color: playButton,
          size: 35.0,
        ),
      ),
    );
  }
}
