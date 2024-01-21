import 'package:shared_preferences/shared_preferences.dart';
import 'package:radio_adblocker/model/radioStation.dart';

/// This class is responsible for loading and saving data to the device.
class ClientDataStorageService {

  /// The id of the favorite radio stations.
  static List<int> favoriteRadioIds = [];

  /// The priorities of the radio stations. <radioId, priority>
  static List<int> RadioPriorities = [];

  /// Maps a list of strings to a list of integers.
  List<int> mapIds(List<String>? ids) {
    return ids?.map((id) => int.parse(id)).toList() ?? [];
  }

  /// Loads the id of the last listened radio station.
  Future<int?> loadLastListenedRadio() async{
    /// load last listened radio id from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lastListenedRadio');
  }

  /// Loads the ids of the favorite radio stations.
  Future<List<int>> loadFavoriteRadioIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    favoriteRadioIds = mapIds(prefs.getStringList("favoriteRadioIds"));

    return favoriteRadioIds;
  }

  Future<List<int>> loadRadioPriorities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    RadioPriorities = mapIds(prefs.getStringList("RadioPriorities"));

    return RadioPriorities;
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

  /// Saves the priority of a radio station.
  /// Index is the priority, value is the radioId
  /// 0 is the highest priority
  Future<void> safeRadioPriorities(List<RadioStation> rList) async {
    rList.sort((a, b) => a.priority.compareTo(b.priority));
    List<int> priorities = [];
    rList.map((e) => priorities.add(e.id));
    List<String> priosString = [];
    priorities.map((e) => priosString.add(e.toString()));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList("RadioPriorities", priosString);
    print("Priorities saved: $priosString");
  }

  bool isFavoriteRadio(int radioId) {

    bool isFavorite = favoriteRadioIds.contains(radioId);

    return isFavorite;
  }
  /// Methode zum Speichern der ID der zuletzt gehörten Radio-Station in shared prefrences
  void saveLastListenedRadio(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('lastListenedRadio',id);
  }

  /// Methode zum Laden der Priorität einer Radio-Station
  int getPriority(int radioId) {
    int priority = RadioPriorities.indexOf(radioId);
    return priority;
  }
}

