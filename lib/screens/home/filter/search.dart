import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio_adblocker/shared/colors.dart';

import '../../../model/radio_station.dart';

/// This class represents the search bar.
///
/// It is used in [FilterOptions] to display the search bar.
/// It contains the text filtering of the radios.
class Search extends StatefulWidget {
  /// The method to run the filter.
  final Function(List<bool Function(RadioStation)>) runFilter;

  /// The list of filter queries.
  final List<bool Function(RadioStation)> filterQueries;

  const Search(
      {super.key, required this.runFilter, required this.filterQueries});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    /// Removes expired filter queries.
    ///
    /// This method is called in [runSearchFilter].
    void removeExpiredFilterQueries(bool Function(RadioStation) filterQuery) {
      widget.filterQueries.removeWhere(
        (existingQuery) => existingQuery.toString() == filterQuery.toString(),
      );
    }

    /// Runs the search filter.
    ///
    /// This method is called in [onChanged].
    /// It takes [value] and [filterQuery] as parameters.
    /// It runs the filter only if [value] is not empty.
    /// If [value] is not empty, it removes the expired filter queries.
    /// It removes the filter from the list if [value] is empty.
    void runSearchFilter(
        String value, bool Function(RadioStation) filterQuery) {
      //run filter only if value != empty
      if (value.isNotEmpty) {
        removeExpiredFilterQueries(
            filterQuery); //remove filter queries otherwise every character will add another filter function
        widget.filterQueries
            .add((filterQuery)); //add new filter to filterQueryList
        widget.runFilter(widget.filterQueries);
      } else {
        removeExpiredFilterQueries(
            filterQuery); //remove filter from list if input is empty
        widget.runFilter(widget.filterQueries);
      }
    }

    return TextField(
      //run runSearchFilter, if the input changes
      onChanged: (value) => runSearchFilter(
          value, //input value
          (radio) => radio.name.toLowerCase().contains(value.toLowerCase())),
      //filter query

      decoration: const InputDecoration(
        // labelText: 'Suche nach Radio...',
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        prefixIcon: Icon(Icons.search, color: defaultFontColor, ),
        hintText: 'Suche nach Radio...',
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        filled: true,
        fillColor: Color(0xff2d2c3c),
      ),
      style: const TextStyle(
        color: defaultFontColor,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
