import 'package:flutter/cupertino.dart';

import '../model/radioStation.dart';

class RadioStationsProvider extends ChangeNotifier {
  List<RadioStation> radios;

  RadioStationsProvider({
    this.radios = const [],
  });

  void changeRadioStationList({
    required List<RadioStation> radios,
  }) {
    this.radios = radios;
    notifyListeners();
  }
}