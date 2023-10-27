class Song {
  final String name;
  final List<String> artists;

  Song.namedParameter({required this.name, required this.artists});
  Song(this.name, this.artists);
}