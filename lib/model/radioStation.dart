import 'package:radio_adblocker/model/song.dart';

class RadioStation { //RadioStation because Radio has name conflicts with package material
  final String name;
  final String streamUrl;
  final String logoUrl;
  final List<String> genres;
  final String status;
  final Song song;
  bool isFavorite;

  RadioStation.namedParameter ({required this.name, required this.streamUrl, required this.logoUrl, required this.genres, required this.status, required this.song, this.isFavorite = false});
  RadioStation (this.name, this.streamUrl, this.logoUrl, this.genres, this.status, this.song, {this.isFavorite = false});

}