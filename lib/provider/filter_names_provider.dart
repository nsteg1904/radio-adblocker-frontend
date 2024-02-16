import 'package:flutter/cupertino.dart';

/// This class provides the names of the pressed filter buttons.
class FilterNamesProvider extends ChangeNotifier {
  /// The list of the names of the filter buttons.
  List<String> _filterNames = [];

  /// Returns the list of the names of the filter buttons.
  List<String> get filterNames => _filterNames;

  /// Sets the list of the names of the filter buttons.
  set filterNames(List<String> names) {
    _filterNames = names;
    notifyListeners();
  }
}