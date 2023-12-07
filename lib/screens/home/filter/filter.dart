import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/model/radioStation.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/filter/search.dart';

import '../../../provider/radioStationsProvider.dart';
import 'filterButton.dart';

/// This class represents the filter options.
///
/// It is used in [Home] to display the filter options.
/// It contains the search bar and the filter buttons.
/// It also contains the logic for filtering the radios.
class FilterOptions extends StatefulWidget {
  const FilterOptions({Key? key}) : super(key: key);

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  /// The List of filter queries, that currently are active.
  List<bool Function(RadioStation)> filterQueries = [];

  @override
  Widget build(BuildContext context) {
    /// The list of all available radios.
    List<RadioStation> radios = context.watch<RadioStationsProvider>().radios;  //all available radios

    /// Sets the radios in the [FilterRadioStationsProvider].
    ///
    /// This method is called in [runFilter].
    /// It is used to set the radios in the [FilterRadioStationsProvider] after filtering them.
    void setRadioStations(List<RadioStation> foundRadios) {
      context
          .read<FilterRadioStationsProvider>()
          .changeRadioStationList(radios: foundRadios);
    }

    /// Runs the filter.
    ///
    /// This method is called in [FilterButton] and [Search].
    /// It is used to filter the radios.
    /// It takes a list of filter queries as parameter.
    /// It iterates through the list and filters the radios.
    /// It sets the filtered radios in the [FilterRadioStationsProvider].
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
