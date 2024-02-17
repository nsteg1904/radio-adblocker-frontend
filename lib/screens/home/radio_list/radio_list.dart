import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/screens/home/radio_list/radio_tile.dart';
import 'package:radio_adblocker/services/websocket_api_service/websocket_radio_list_service.dart';
import 'package:radio_adblocker/shared/colors.dart';
import '../../../model/radio_station.dart';
import '../../../provider/filter_queries_provider.dart';
import '../../../provider/filter_names_provider.dart';
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

    final List<String> filterNames = Provider.of<FilterNamesProvider>(context).filterNames;

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: backgroundColor,
            shadowColor: backgroundColor,
            child: child,
          );
        },
        child: child,
      );
    }

    if (filterNames.contains("Fluchtradios")) {
      rList.isNotEmpty ? rList.sort((a, b) => a.priority.compareTo(b.priority)) : rList = [];
      return ReorderableListView.builder(
        proxyDecorator: proxyDecorator,
        itemBuilder: (context, index) {
          return RadioTile(radio: rList[index], key: ValueKey('$index'), reorderable: true, index: index);
        },
        itemCount: rList.length,
        onReorder: (int oldIndex, int newIndex) async {
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
      rList.isNotEmpty ? rList.sort((a, b) => a.id.compareTo(b.id)) : rList = [];
      return ListView.builder(
        itemCount: rList.length,
        itemBuilder: (context, index) {
          return RadioTile(radio: rList[index], key: ValueKey('$index'), reorderable: false, index: index);
        },
      );
    }
  }
}
