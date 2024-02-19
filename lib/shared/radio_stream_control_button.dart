import 'dart:async';

import 'package:flutter/material.dart';

import '../services/audio_player_radio_stream_service.dart';


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

  /// The stream manager to control the radio stream.
  late AudioPlayerRadioStreamManager streamManager;

  /// Listen to the stream status to update the play/pause button.
  late StreamSubscription<bool> _streamSubscription;

  /// Used to toggle the play/pause icon.;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    /// Initialize the stream manager.
    streamManager = AudioPlayerRadioStreamManager();

    /// Get the current stream status.
    isPlaying = streamManager.isPlaying;

    /// Listen to the stream status to update the play/pause button.
    _streamSubscription = streamManager.isPlayingStream
        .listen((playing) => setState(() => isPlaying = playing));
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// Toggle the radio stream between play and pause.
    Future<void> togglePlayPause() async {
      streamManager.isPlaying
          ? await streamManager.stopRadio()
          : await streamManager.playRadio();
      setState(() => isPlaying = streamManager.isPlaying);
    }

    return CircleAvatar(
      radius: 27.0 * widget.size, // to scale Widget size
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: togglePlayPause,
        iconSize: 35 * widget.size,
        icon: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
