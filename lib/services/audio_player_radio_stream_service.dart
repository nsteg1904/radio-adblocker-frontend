import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';

/// This class is responsible for managing the radio stream.
///
/// It is used in [RadioStreamControlButton] to start and stop the radio stream.
class AudioPlayerRadioStreamManager {
  /// The singleton instance of this class.
  static final AudioPlayerRadioStreamManager _instance =
  AudioPlayerRadioStreamManager._internal();

  /// The [AudioPlayer] that is used to play the radio stream.
  late final AudioPlayer _audioPlayer;

  /// The stream controller to notify the UI about the current play/pause state.
  late StreamController<bool> _isPlayingController;
  Stream<bool> get isPlayingStream => _isPlayingController.stream;

  /// The URL of the radio stream.
  String? streamUrl;

  /// The constructor in which the [AudioPlayer] is initialized.
  ///
  /// The constructor to get the singleton instance of this class.
  factory AudioPlayerRadioStreamManager() => _instance;


  /// The private constructor in which the [AudioPlayer] is initialized.
  ///
  /// The constructor is private because this class is a singleton.
  AudioPlayerRadioStreamManager._internal() {
    _audioPlayer = AudioPlayer();
    _isPlayingController = StreamController<bool>.broadcast();
  }

  /// Whether the radio stream is currently playing.
  bool get isPlaying => _audioPlayer.playing;

  /// Sets the radio stream source to the given URL.
  ///
  /// If the given URL is null or the same as the current URL, nothing happens.
  Future<void> setRadioSource(String? url) async {
    if (url == null || streamUrl == url) return;

    await _audioPlayer.setUrl(url);
    streamUrl = url;
    print("Set radio source");
  }

  /// Starts the radio stream.
  Future<void> playRadio() async {
    /// If the radio stream is already playing, nothing happens.
    try {
      _isPlayingController.add(true);
      await _audioPlayer.play();
      print("Start radio");
    } on PlatformException catch (e) { // PlatformException is thrown when the radio stream is already playing
      print('Error occurred: $e');
    }
  }

  /// Pauses the radio stream.
  Future<void> stopRadio() async {
    _isPlayingController.add(false);
    await _audioPlayer.pause();
    print("Stop radio");
  }

  void dispose() {
    _isPlayingController.close();
    _audioPlayer.dispose();
  }
}
