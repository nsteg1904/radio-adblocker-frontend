import 'package:flutter/cupertino.dart';

import '../model/radioStation.dart';

/// This class is a Provider that holds the list of radio stations that are currently displayed.
///
/// It is used in [Filter] to filter the list of radio stations.
/// The list of radio stations is displayed in [RadioList].
class FilterRadioStationsProvider extends ChangeNotifier {

  /// The list of radio stations that are currently displayed.
  List<RadioStation> radios = [];

  /// The constructor in which the list of radio stations can optionally be set.
  FilterRadioStationsProvider({
    List<RadioStation> radios = const [],
  });

  /// Updates the list of radio stations.
  void changeRadioStationList({
    required List<RadioStation> radios,
  }) {
    this.radios = radios;
    notifyListeners();
  }
}
