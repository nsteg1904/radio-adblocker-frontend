import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/screens/home/radioList/radioTile.dart';
import 'package:radio_adblocker/services/websocket_api_service/websocket_radio_list_service.dart';
import '../../../model/radioStation.dart';
import '../../../provider/filter_Queries_Provider.dart';
import '../../../services/client_data_storage_service.dart';
import 'package:collection/collection.dart';

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

    final radioList = Provider.of<List<RadioStation>>(context);
    final radioPriorities = ClientDataStorageService().loadRadioPriorities();
    //Prioritäten zuordnen
    for (final radio in radioList) {
      radio.priority = ClientDataStorageService().getPriority(radio.id);
    }

    //Liste nach Prioritäten sortieren
    var sortedRadioList = List<RadioStation>.from(radioList);
    sortedRadioList.sort((a, b) => a.priority.compareTo(b.priority));
    //Zum initialisieren indexe als Prioritäten speichern

    int i = 0;
    for (final radio in sortedRadioList) {
      radio.priority = i;
      i++;
    }

    print("Priorities nach initialisierung: ");
    for (final radio in sortedRadioList) {
      print(radio.priority.toString());
    }

    final filterQueries = Provider.of<FilterQueriesProvider>(context).filterQueries;
    //TODO: Filterqueries abgleichen, um zu identifizieren, welcher Filter aktiv ist

    List<RadioStation> runFilter(List<bool Function(RadioStation)> filterQueries, List<RadioStation> radios) {
      List<RadioStation> filteredRadios = radios;

      for (final query in filterQueries) {
        filteredRadios = filteredRadios.where(query).toList();
      }

      return filteredRadios;
    }

    List<RadioStation> rList = runFilter(filterQueries, sortedRadioList);
    rList.isNotEmpty ? rList.sort((a, b) => a.priority.compareTo(b.priority)) : rList = [];

    // return ListView.builder(
    //   itemCount: rList.length,
    //   itemBuilder: (context, index) {
    //     return RadioTile(radio: rList[index]);
    //   },
    // );


    return ReorderableListView.builder(
        itemBuilder: (context, index) {
          return RadioTile(radio: rList[index], key: ValueKey('$index'));
        },
        itemCount: rList.length,
        onReorder: (int oldIndex, int newIndex) {
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
          rList.map((e) => e.priority = rList.indexOf(e));
          print("Priorities: ");
          for (final radio in rList) {
            print(radio.priority.toString());
          }
          rList.map((e) => print(e.priority));
          //Persistieren der neuen Reihenfolge
          ClientDataStorageService().safeRadioPriorities(rList);
        },
    );
  }
}
