import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/currentRadioProvider.dart';
import 'colors.dart';

class AudioButton extends StatefulWidget {
  final double size;
  AudioButton({super.key, this.size = 1.0});

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  // @override
  // void dispose() {
  //   final currentRadioProvider = context.read<CurrentRadioProvider>();
  //   currentRadioProvider.audioPlayer.dispose(); // release audio player
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final currentRadioProvider = context.read<CurrentRadioProvider>();
    final player = context.read<CurrentRadioProvider>().audioPlayer;
    final isPlaying = context.watch<CurrentRadioProvider>().isPlaying;

    // toggle play/pause
    Future<void> togglePlayPause() async {
      isPlaying ? await player.stop() : await player.resume();

      currentRadioProvider.setIsPlaying(isPlaying: !isPlaying);
    }

    return CircleAvatar(
      radius: 27.0 * widget.size, // to scale Widget size
      backgroundColor: playButtonBackground,
      child: IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: togglePlayPause,
        icon: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: playButton,
          size: 35.0 * widget.size, // to scale Widget size
        ),
      ),
    );
  }
}
