import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/model/radioStation.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';

import '../../provider/radioStationsProvider.dart';

class FilterOptions extends StatelessWidget {
  const FilterOptions({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<RadioStation> filterRadios = context.watch<FilterRadioStationsProvider>().radios;
    List<RadioStation> radios = context.watch<RadioStationsProvider>().radios;

    return TextField(
      onChanged: (String value) {
        if (value.isNotEmpty) {

          //get found radios
          List<RadioStation> foundRadios = filterRadios
              .where((radio) =>
                  radio.name.toLowerCase().contains(value.toLowerCase()))
              .toList();

          //set found radios
          context.read<FilterRadioStationsProvider>().changeRadioStationList(radios: foundRadios);

        } else {

          //if input String empty set list to default
          context
              .read<FilterRadioStationsProvider>()
              .changeRadioStationList(radios: radios);
        }
      },
      decoration: const InputDecoration(
          labelText: 'Suche nach Radio...', suffixIcon: Icon(Icons.search)),
    );
  }
}
