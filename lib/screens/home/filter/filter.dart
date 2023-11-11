import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/model/radioStation.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/filter/search.dart';

import '../../../provider/radioStationsProvider.dart';
import 'filterButton.dart';

class FilterOptions extends StatefulWidget {
  const FilterOptions({Key? key}) : super(key: key);

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  List<bool Function(RadioStation)> filterQueries = [];

  @override
  Widget build(BuildContext context) {
    List<RadioStation> radios = context.watch<RadioStationsProvider>().radios;  //all available radios

    void setRadioStations(List<RadioStation> foundRadios) {
      context
          .read<FilterRadioStationsProvider>()
          .changeRadioStationList(radios: foundRadios);
    }

    void runFilter(List<bool Function(RadioStation)> filterQueries) {
      List<RadioStation> filteredRadios = radios;

      for (final query in filterQueries) {
        filteredRadios = filteredRadios.where(query).toList();
      }

      setRadioStations(filteredRadios);
    }

    return Column(
      children: [
        Search(
          runFilter: runFilter,
          filterQueries: filterQueries,
        ),
        Row(
          children: [
            FilterButton(
              name: "Fluchtradios",
              filterQuery: (radio) => radio.isFavorite,
              runFilter: runFilter,
              filterQueries: filterQueries,
            ),
            FilterButton(
              name: "Aktuell werbefrei",
              filterQuery: (radio) => radio.status != "add",
              runFilter: runFilter,
              filterQueries: filterQueries,
            ),
          ],
        ),
      ],
    );
  }
}
