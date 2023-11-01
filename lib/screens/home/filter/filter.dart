import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/model/radioStation.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/filter/search.dart';

import '../../../provider/radioStationsProvider.dart';
import 'filterButton.dart';

class FilterOptions extends StatelessWidget {
  const FilterOptions({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    //current filtered radios
    List<RadioStation> filterRadios = context.watch<FilterRadioStationsProvider>().radios;
    //current radios
    List<RadioStation> radios = context.watch<RadioStationsProvider>().radios;

    return Column(
      children: [
        Search(
          radios: radios,
          filterRadios: filterRadios,

        ),
        Row(
          children: [
            FilterButton(
                name: "Fluchtradios",
                filterQuery: (radio) => radio.isFavorite,
                radios: radios,
                filterRadios: filterRadios,

            ),
            FilterButton(
                name: "Aktuell Werbefrei",
                filterQuery: (radio) => radio.status != "add",
                radios: radios,
                filterRadios: filterRadios,

            ),
          ],
        ),
      ],
    );
  }
}





