import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/radioStation.dart';

class Search extends StatefulWidget {
  final Function(List<bool Function(RadioStation)>) runFilter;
  final List<bool Function(RadioStation)> filterQueries;

  const Search(
      {super.key, required this.runFilter, required this.filterQueries});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    //removes search filter queries
    void removeExpiredFilterQueries(bool Function(RadioStation) filterQuery) {
      widget.filterQueries.removeWhere(
        (existingQuery) => existingQuery.toString() == filterQuery.toString(),
      );
    }

    void runSearchFilter(
        String value, bool Function(RadioStation) filterQuery) {
      //run filter only if value != empty
      if (value.isNotEmpty) {
        removeExpiredFilterQueries(filterQuery); //remove filter queries otherwise every character will add another filter function
        widget.filterQueries.add((filterQuery)); //add new filter to filterQueryList
        widget.runFilter(widget.filterQueries);
      } else {
        removeExpiredFilterQueries(filterQuery); //remove filter from list if input is empty
        widget.runFilter(widget.filterQueries);
      }
    }

    return TextField(
      //run runSearchFilter, if the input changes
      onChanged: (value) => runSearchFilter(
          value, //input value
          (radio) => radio.name.toLowerCase().contains(value.toLowerCase())), //filter query

      decoration: const InputDecoration(
        // labelText: 'Suche nach Radio...',
        prefixIcon: Icon(Icons.search),
        hintText: 'Suche nach Radio...',
        hintStyle: TextStyle(color: Colors.white,),
        filled: true,
        fillColor: Color(0xff2d2c3c),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
