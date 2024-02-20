/// This class represents a song.
class Song {
  /// The name of the song.
  final String name;
  /// The artists of the song.
  final String artist;

  /// Constructors for a song.
  Song.namedParameter({required this.name, required this.artist});
  Song(this.name, this.artist);
}