/// This class represents a song.
class Song {
  /// The name of the song.
  final String name;
  /// The artists of the song.
  final List<String> artists;

  /// Constructors for a song.
  Song.namedParameter({required this.name, required this.artists});
  Song(this.name, this.artists);
}