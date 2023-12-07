import 'package:flutter/cupertino.dart';

import '../model/radioStation.dart';

/// This class is a Provider that holds the list of all available radio stations.
///
/// It is used in [Filter] to apply the filter on the list of all available radio stations
/// and set the [FilterRadioStationsProvider].
class RadioStationsProvider extends ChangeNotifier {

  /// The list of all available radio stations.
  List<RadioStation> radios;

  /// The constructor in which the list of all available radio stations can optionally be set.
  RadioStationsProvider({
    this.radios = const [],
  });

  /// Updates the list of all available radio stations.
  void changeRadioStationList({
    required List<RadioStation> radios,
  }) {
    this.radios = radios;
    notifyListeners();
  }
}