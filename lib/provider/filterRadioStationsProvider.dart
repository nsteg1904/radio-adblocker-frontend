import 'package:flutter/cupertino.dart';

import '../model/radioStation.dart';

class FilterRadioStationsProvider extends ChangeNotifier {
  List<RadioStation> radios;

  FilterRadioStationsProvider({
    this.radios = const [],
  });

  void changeRadioStationList({
    required List<RadioStation> radios,
  }) {
    this.radios = radios;
    notifyListeners();
  }
}
