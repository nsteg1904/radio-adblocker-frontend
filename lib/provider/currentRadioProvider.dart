import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import '../model/radioStation.dart';

class CurrentRadioProvider extends ChangeNotifier {
  RadioStation _currentRadio;
  bool _isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();

  CurrentRadioProvider(RadioStation currentRadio,{bool isPlaying = false}) : _currentRadio = currentRadio, _isPlaying = isPlaying;

  RadioStation get currentRadio => _currentRadio;
  bool get isPlaying => _isPlaying;

  void setRadio({
    required RadioStation radio,
  }) {
    _currentRadio = radio;
    notifyListeners();
  }

  void setIsPlaying({
    required bool isPlaying,
  }) {
    _isPlaying = isPlaying;
    notifyListeners();
  }

  Future<void> setAudioStream({
    required String url,
  }) async {
    await audioPlayer.setSource(UrlSource(url));
  }


}
