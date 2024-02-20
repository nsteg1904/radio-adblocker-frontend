import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/model/radio_station.dart';
import 'package:radio_adblocker/screens/home/filter/search.dart';

import '../../../provider/filter_names_provider.dart';
import '../../../provider/filter_queries_provider.dart';
import '../../../services/client_data_storage_service.dart';
import 'filter_button.dart';

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
  /// The List of names of the filters that are currently active.
  List<String> filterNames = [];

  @override
  Widget build(BuildContext context) {

    /// Sets the filter queries in the [FilterQueriesProvider].
    void setFilterQueriesProvider(List<bool Function(RadioStation)> filterQueries) {
      context.read<FilterQueriesProvider>().filterQueries = filterQueries;
    }

    ///Sets the filter names in the [FilterNamesProvider].
    void setFilterNamesProvider(List<String> filterNames) {
      context.read<FilterNamesProvider>().filterNames = filterNames;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
      children: [
        Search(
          runFilter: setFilterQueriesProvider,
          filterQueries: filterQueries,
        ),
        Row(
          children: [
            FilterButton(
              name: "Fluchtradios",
              filterNames: filterNames,
              provideNames: setFilterNamesProvider,
              filterQuery: (radio) => ClientDataStorageService().isFavoriteRadio(radio.id),
              runFilter: setFilterQueriesProvider,
              filterQueries: filterQueries,
            ),
            FilterButton(
              name: "Aktuell werbefrei",
              filterNames: filterNames,
              provideNames: setFilterNamesProvider,
              filterQuery: (radio) => radio.status != "1",
              runFilter: setFilterQueriesProvider,
              filterQueries: filterQueries,
            ),
          ],
        ),
      ],
    )
    );
  }
}
