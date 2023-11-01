import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/radioStation.dart';
import '../../../provider/filterRadioStationsProvider.dart';

class Search extends StatefulWidget {
  final List<RadioStation> filterRadios;
  final List<RadioStation> radios;
  const Search({super.key, required this.filterRadios, required this.radios});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {

    void setRadioStations(List<RadioStation> foundRadios) {
      context
          .read<FilterRadioStationsProvider>()
          .changeRadioStationList(radios: foundRadios);
    }

    List<RadioStation> runListFilter(bool Function(RadioStation) filterQuery) {
      return widget.filterRadios.where(filterQuery).toList();
    }

    void runSearchFilter(String value, bool Function(RadioStation) filterQuery) {
      value.isNotEmpty
          ? setRadioStations(runListFilter((filterQuery))) //set search filter
          : setRadioStations(widget.radios); //reset filter
    }

    return TextField(
      onChanged: (value) => runSearchFilter(
          value, (radio) =>
              radio.name.toLowerCase().contains(value.toLowerCase())),
      decoration: const InputDecoration(
          labelText: 'Suche nach Radio...', suffixIcon: Icon(Icons.search)),
    );
  }
}
