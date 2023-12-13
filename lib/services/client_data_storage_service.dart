import 'package:shared_preferences/shared_preferences.dart';

/// This class is responsible for loading and saving data to the device.
class ClientDataStorageService {

  /// The id of the favorite radio stations.
  static List<int> favoriteRadioIds = [];

  /// Maps a list of strings to a list of integers.
  List<int> mapIds(List<String>? ids) {
    return ids?.map((id) => int.parse(id)).toList() ?? [];
  }

  /// Loads the id of the last listened radio station.
  int? loadLastListenedRadio() {
    ///TODO: load last listened radio id from shared preferences
    return 1;
  }

  /// Loads the ids of the favorite radio stations.
  Future<List<int>> loadFavoriteRadioIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    favoriteRadioIds = mapIds(prefs.getStringList("favoriteRadioIds"));

    return favoriteRadioIds;
  }

  /// Saves the favorite state of a radio station.
  ///
  /// This method is called in [toggleFavorite].
  /// It takes [radioId] as parameter.
  /// It uses the [SharedPreferences] package to persist the favorites..
  Future<void> safeFavoriteState(int radioId) async {
    String id = radioId.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList("favoriteRadioIds") ?? [];

    favorites.contains(id) ? favorites.remove(id) : favorites.add(id);

    favoriteRadioIds = mapIds(favorites);

    prefs.setStringList("favoriteRadioIds", favorites);
  }

  bool isFavoriteRadio(int radioId) {

    bool isFavorite = favoriteRadioIds.contains(radioId);

    return isFavorite;
  }


}