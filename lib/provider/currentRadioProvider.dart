import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import '../model/radioStation.dart';

/// This class is a Provider that holds the current radio station and the current state of the player.
///
/// It is used in [RadioTile] to set the current radio station and in [AudioButton] to get the current state of the player.
class CurrentRadioProvider extends ChangeNotifier {

  /// The current radio station.
  RadioStation _currentRadio;
  /// Whether the player is playing or not.
  bool _isPlaying = false;
  /// The audio player.
  final AudioPlayer _audioPlayer = AudioPlayer();

  CurrentRadioProvider(RadioStation currentRadio, {bool isPlaying = false})
      : _currentRadio = currentRadio,
        _isPlaying = isPlaying;

  /// The audio player.
  AudioPlayer get audioPlayer => _audioPlayer;

  /// The current radio station.
  ///
  /// This method is called in [CurrentRadio] to display the current radio station.
  RadioStation get currentRadio => _currentRadio;

  /// Updates the current radio station and sets the audio stream.
  ///
  /// This method is called in [RadioTile] when the user taps on a radio station.
  Future<void> setCurrentRadio({
    required RadioStation radio,
  }) async {
    _currentRadio = radio;
    await _setAudioStream(url: radio.streamUrl);
    notifyListeners();
  }

  /// Whether the player is playing or not.
  ///
  /// This method is called in [AudioButton] when the user taps on the play/pause button.
  bool get isPlaying => _isPlaying;
  void setIsPlaying({
    required bool isPlaying,
  }) {
    _isPlaying = isPlaying;
    notifyListeners();
  }

  /// Sets the audio stream.
  Future<void> _setAudioStream({
    required String url,
  }) async {
    await _audioPlayer.setSource(UrlSource(url));
    notifyListeners();
  }
}
