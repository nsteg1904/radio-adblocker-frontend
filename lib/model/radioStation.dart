import 'package:radio_adblocker/model/song.dart';

/// This class represents a radio station.
class RadioStation { //RadioStation because Radio has name conflicts with package material
  /// The id of the radio given by the API.
  final int id;
  /// The name of the radio station.
  final String name;
  /// The stream url of the radio station.
  final String streamUrl;
  /// The logo url of the radio station.
  final String logoUrl;
  /// The genres of the radio station.
  List<String> genres;
  /// The status of the radio station.
  ///
  /// It is either "add", "news", "moderation" or "music".
  final String status;
  /// The current song of the radio station.
  final Song song;
  /// Whether the radio station is a favorite or not.
  bool isFavorite;

  /// Constructors for a radio station.
  RadioStation.namedParameter ({required this.id, required this.name, required this.streamUrl, required this.logoUrl, required this.status, required this.song, this.isFavorite = false, this.genres = const []});
  RadioStation (this.id,this.name, this.streamUrl, this.logoUrl, this.genres, this.status, this.song, {this.isFavorite = false});

}