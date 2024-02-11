import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/model/radioStation.dart';
import 'package:radio_adblocker/screens/home/filter/search.dart';

import '../../../provider/filter_Queries_Provider.dart';
import '../../../services/client_data_storage_service.dart';
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

    /// Sets the filter queries in the [FilterQueriesProvider].
    void setFilterQueriesProvider(List<bool Function(RadioStation)> filterQueries) {
      context.read<FilterQueriesProvider>().filterQueries = filterQueries;
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
                filterQuery: (radio) => ClientDataStorageService().isFavoriteRadio(radio.id),
                runFilter: setFilterQueriesProvider,
                filterQueries: filterQueries,
              ),
              FilterButton(
                name: "Aktuell werbefrei",
                filterQuery: (radio) => radio.status != "1",
                runFilter: setFilterQueriesProvider,
                filterQueries: filterQueries,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
