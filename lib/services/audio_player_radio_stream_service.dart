import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:get/get.dart';
/// This class is responsible for managing the radio stream.
///
/// It is used in [RadioStreamControlButton] to start and stop the radio stream.
class AudioPlayerRadioStreamManager {
  /// The singleton instance of this class.
  static final AudioPlayerRadioStreamManager _instance =
  AudioPlayerRadioStreamManager._internal();
  /// The [AudioPlayer] that is used to play the radio stream.
  late final AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  /// The URL of the radio stream.
  String? streamUrl;
  bool _isConnected = true; // Default assumption: connected
  /// The constructor in which the [AudioPlayer] is initialized.
  ///
  /// The constructor to get the singleton instance of this class.
  factory AudioPlayerRadioStreamManager() => _instance;
  /// The private constructor in which the [AudioPlayer] is initialized.
  ///
  /// The constructor is private because this class is a singleton.
  AudioPlayerRadioStreamManager._internal() {
    _audioPlayer = AudioPlayer();
    _initConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      _handleConnectivityChange(result);
    });
  }
  /// Whether the radio stream is currently playing.
  bool get isPlaying => _isPlaying;

  /// Sets the radio stream source to the given URL.
  ///
  /// If the given URL is null or the same as the current URL, nothing happens.
  Future<void> setRadioSource(String? url) async {
    if (url == null || streamUrl == url) return;
    if (!_isConnected) {
      print('No internet connection. Cannot set radio source.');
      return;
    }
    await _audioPlayer.setSourceUrl(url);
    streamUrl = url;
    print("Set radio source");
  }

  /// Starts the radio stream.
  Future<void> playRadio() async {
    if (!_isConnected) {
      print('No internet connection. Cannot start radio.');
      return;
    }
    /// If the radio stream is already playing, nothing happens.
    try {
      await WakelockPlus.enable(); // enable wakelock_plus when radio starts
      await _audioPlayer.resume();
      print("Start radio");
      _isPlaying = true;
    } on PlatformException catch (e) { // PlatformException is thrown when the radio stream is already playing
      print('Error occurred: $e');
    }
  }

  /// Pauses the radio stream.
  Future<void> stopRadio() async {
    await _audioPlayer.pause();
    await WakelockPlus.disable(); // Disable wakelock_plus when radio stops
    print("Stop radio");
    _isPlaying = false;
  }
  /// Initializes the connectivity plugin.
  Future<void> _initConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity(); // Updated connectivity check
    _handleConnectivityChange(connectivityResult);
  }
   /// Handles the connectivity change.
  void _handleConnectivityChange(ConnectivityResult result) {
    _setState(() {
      _isConnected = (result != ConnectivityResult.none);

      if (!_isConnected && _isPlaying) {
        stopRadio(); // If connection is lost during playback, stop the radio
        Get.rawSnackbar(
          message: 'Please connect to internet and restart the app to play radio',
          duration: const Duration(days: 1),
        );
      }
      else if (!_isConnected && !_isPlaying) {
        Get.rawSnackbar(
          message:'Please connect to internet and restart the app to play radio',
          duration: const Duration(days: 1),
        );
      }
      else {
        if(Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
      }
    });
  }
  /// Sets the state of this class.
  void _setState(void Function() func) {
    func();
  }
}
