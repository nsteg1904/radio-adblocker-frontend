import 'package:flutter/material.dart';

import '../services/audio_player_radio_stream_service.dart';
import 'colors.dart';

/// A button to control the radio stream.
class RadioStreamControlButton extends StatefulWidget {
  /// To scale Widget size.
  final double size;

  const RadioStreamControlButton({super.key, this.size = 1.0});

  @override
  State<RadioStreamControlButton> createState() =>
      _RadioStreamControlButtonState();
}

class _RadioStreamControlButtonState extends State<RadioStreamControlButton> {
  /// Used to toggle the play/pause icon.
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    AudioPlayerRadioStreamManager streamManager = AudioPlayerRadioStreamManager();

    /// Toggle the radio stream between play and pause.
    Future<void> togglePlayPause() async {
      streamManager.isPlaying
          ? await streamManager.stopRadio()
          : await streamManager.playRadio();
      setState(() => isPlaying = streamManager.isPlaying);
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
