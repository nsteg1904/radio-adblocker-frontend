import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/radioList/radioTile.dart';
import '../../../model/radioStation.dart';

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

    List<RadioStation> radioList = context.watch<FilterRadioStationsProvider>().radios;

    return ListView.builder(
      itemCount: radioList.length,
      itemBuilder: (context, index) {
        return RadioTile(radio: radioList[index]);
      },
    );
  }
}
