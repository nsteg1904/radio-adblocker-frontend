import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/screens/home/radioList/radioTile.dart';
import 'package:radio_adblocker/services/websocket_api_service/websocket_radio_list_service.dart';
import '../../../model/radioStation.dart';
import '../../../provider/filter_Queries_Provider.dart';

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
    List<RadioStation> rList = runFilter(filterQueries, radioList);
    rList.isNotEmpty ? rList.sort((a, b) => a.id.compareTo(b.id)) : rList = [];

    return ListView.builder(
      itemCount: rList.length,
      itemBuilder: (context, index) {
        return RadioTile(radio: rList[index]);
      },
    );
  }
}
