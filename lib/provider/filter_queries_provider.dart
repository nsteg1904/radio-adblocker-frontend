import 'package:flutter/material.dart';

import '../model/radio_station.dart';

class FilterQueriesProvider with ChangeNotifier {
  List<bool Function(RadioStation)> _filterQueries = [];

  List<bool Function(RadioStation)> get filterQueries => _filterQueries;

  set filterQueries(List<bool Function(RadioStation)> queries) {
    _filterQueries = queries;
    notifyListeners();
  }

}