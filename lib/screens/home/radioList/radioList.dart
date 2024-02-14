import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/screens/home/radioList/radioTile.dart';
import 'package:radio_adblocker/services/websocket_api_service/websocket_radio_list_service.dart';
import '../../../model/radioStation.dart';
import '../../../provider/filter_Queries_Provider.dart';
import '../../../provider/filterNamesProvider.dart';
import '../../../services/client_data_storage_service.dart';

/// This class represents the list of radios.
///
/// It is used in [Home] to display the list of radios
/// and contains the logic for displaying the radios.
class RadioList extends StatefulWidget {
  const RadioList({super.key});

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {

  @override
  Widget build(BuildContext context) {
    if (WebSocketRadioListService.remainingUpdates == 0) {
      WebSocketRadioListService.requestRadioList(10);
    }

    /// List of radios
    final radioList = Provider.of<List<RadioStation>>(context);
    /// List of filter queries
    ClientDataStorageService().loadRadioPriorities();
    //Prioritäten zuordnen
    for (final radio in radioList) {
      radio.priority = ClientDataStorageService().getPriority(radio.id);
    }

    //Liste nach Prioritäten sortieren
    var sortedRadioList = List<RadioStation>.from(radioList);
    sortedRadioList.sort((a, b) => a.priority.compareTo(b.priority));


    final filterQueries = Provider.of<FilterQueriesProvider>(context).filterQueries;
    //TODO: Filterqueries abgleichen, um zu identifizieren, welcher Filter aktiv ist

    /// Filters the radios based on the filter queries.
    ///
    /// The filter queries are a list of functions that take a [RadioStation] and return a boolean.
    /// The radios are filtered by applying each filter query to the list of radios.
    List<RadioStation> runFilter(List<bool Function(RadioStation)> filterQueries, List<RadioStation> radios) {
      List<RadioStation> filteredRadios = radios;

      for (final query in filterQueries) {
        filteredRadios = filteredRadios.where(query).toList();
      }

      return filteredRadios;
    }

    /// Sorts the radios by their id.
    List<RadioStation> rList = runFilter(filterQueries, sortedRadioList);
    rList.isNotEmpty ? rList.sort((a, b) => a.priority.compareTo(b.priority)) : rList = [];

    // return ListView.builder(
    //   itemCount: rList.length,
    //   itemBuilder: (context, index) {
    //     return RadioTile(radio: rList[index]);
    //   },
    // );

    final List<String> filterNames = Provider.of<FilterNamesProvider>(context).filterNames;

    if (filterNames.contains("Fluchtradios")) {
      print("Filter: Fluchtradios");
      return ReorderableListView.builder(
        itemBuilder: (context, index) {
          return RadioTile(radio: rList[index], key: ValueKey('$index'), reorderable: true);
        },
        itemCount: rList.length,
        onReorder: (int oldIndex, int newIndex) async {
          if (oldIndex > rList.length && newIndex > rList.length) {
            print("oldIndex: $oldIndex, newIndex: $newIndex");
          }
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final RadioStation item = rList.removeAt(oldIndex);
            rList.insert(newIndex, item);
          });
          //Index als Priorität speichern
          rList.map((e) => e.priority = rList.indexOf(e)).toList();
          //Persistieren der neuen Reihenfolge
          await ClientDataStorageService().safeRadioPriorities(rList);
        },
      );
    }
    else {
      print("Filter: Kein Filter aktiv");
      return ListView.builder(
        itemCount: rList.length,
        itemBuilder: (context, index) {
          return RadioTile(radio: rList[index], key: ValueKey('$index'), reorderable: false);
        },
      );
    }
  }
}
