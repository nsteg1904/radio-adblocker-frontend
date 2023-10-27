import 'package:radio_adblocker/model/song.dart';

class RadioStation { //RadioStation because Radio has name conflicts with package material
  final String name;
  final String url;
  final String image;
  final List<String> genres;
  final String status;
  final Song song;

  RadioStation.namedParameter ({required this.name, required this.url, required this.image, required this.genres, required this.status, required this.song});
  RadioStation (this.name, this.url, this.image, this.genres, this.status, this.song);

}