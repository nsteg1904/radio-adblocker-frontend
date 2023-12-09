import 'package:shared_preferences/shared_preferences.dart';

/// This class is responsible for loading and saving data to the device.
class ClientDataStorageService {

  /// Loads the id of the last listened radio station.
  int? loadLastListenedRadio() {
    ///TODO: load last listened radio id from shared preferences
    return 1;
  }

  /// Loads the ids of the favorite radio stations.
  Future<List<int>> loadFavoriteRadioIds() async {
    List<int> favoriteRadioIds = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    favoriteRadioIds = prefs
        .getStringList("favoriteRadioIds")
        ?.map((id) => int.parse(id))
        .toList()
        ?? [];

    return favoriteRadioIds;
  }

  /// Saves the favorite state of a radio station.
  ///
  /// This method is called in [toggleFavorite].
  /// It takes [radioId] as parameter.
  /// It uses the [SharedPreferences] package to persist the favorites..
  void safeFavoriteState(int radioId) async {
    String id = radioId.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList("favoriteRadioIds") ?? [];

    favorites.contains(id) ? favorites.remove(id) : favorites.add(id);


    prefs.setStringList("favoriteRadioIds", favorites);
  }


}