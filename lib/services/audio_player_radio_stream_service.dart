import 'package:audioplayers/audioplayers.dart';

/// This class is responsible for managing the radio stream.
///
/// It is used in [RadioStreamControlButton] to start and stop the radio stream.
class AudioPlayerRadioStreamManager {
  /// The singleton instance of this class.
  static final AudioPlayerRadioStreamManager _instance = AudioPlayerRadioStreamManager._internal();
  /// Whether the radio stream is currently playing.
  bool _isPlaying = false;
  /// The URL of the radio stream.
  String? streamUrl;
  /// The [AudioPlayer] that is used to play the radio stream.
  late final AudioPlayer _audioPlayer;

  /// The constructor in which the [AudioPlayer] is initialized.
  ///
  /// The constructor to get the singleton instance of this class.
  factory AudioPlayerRadioStreamManager() => _instance;

  /// The private constructor in which the [AudioPlayer] is initialized.
  ///
  /// The constructor is private because this class is a singleton.
  AudioPlayerRadioStreamManager._internal() {
    _audioPlayer = AudioPlayer();
  }

  /// Whether the radio stream is currently playing.
  bool get isPlaying => _isPlaying;

  /// Sets the radio stream source to the given URL.
  ///
  /// If the given URL is null or the same as the current URL, nothing happens.
  Future<void> setRadioSource(String? url) async {
    if(url == null || streamUrl == url) return;
    await _audioPlayer.setSource(UrlSource(url));
    streamUrl = url;
    print("Set radio source");
  }

  /// Starts the radio stream.
  Future<void> playRadio() async {
    await _audioPlayer.resume();
    print("start radio");
    _isPlaying = true;
  }

  /// Pauses the radio stream.
  Future<void> stopRadio() async {
    await _audioPlayer.pause();
    print("stop radio");
    _isPlaying = false;
  }
}