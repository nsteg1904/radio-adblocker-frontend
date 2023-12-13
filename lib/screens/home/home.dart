import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/currentRadio.dart';
import 'package:radio_adblocker/screens/home/filter/filter.dart';
import 'package:radio_adblocker/screens/home/headline.dart';
import 'package:radio_adblocker/screens/home/radioList/radioList.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/radioStation.dart';
import '../../provider/radioStationsProvider.dart';

/// This class represents the home screen.
///
/// It is the first screen the user sees when opening the app.
/// It contains the headline, the filter options, the radio list and the current radio.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState()  {
    super.initState();
    //initializeData();
  }

  // void initializeData() async {
  //   List<RadioStation> radioList = Provider.of<List<RadioStation>>(context);
  //
  //   List<int> rList = await loadFavoriteRadioIds();
  //
  //   for(int id in rList){
  //     radioList.where((radio) => radio.id == id).first.isFavorite = true;
  //   }
  //
  //   //to ensure that the code is only called after the build phase
  //   Future.microtask(() {
  //     final filterRadioStationsProvider =
  //         context.read<FilterRadioStationsProvider>();
  //     final radioStationsProvider = context.read<RadioStationsProvider>();
  //
  //     radioStationsProvider.changeRadioStationList(radios: radioList);
  //     filterRadioStationsProvider.changeRadioStationList(radios: radioList);
  //   });
  // }

  Future<List<int>> loadFavoriteRadioIds() async {
    List<int> favoriteRadioIds = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    favoriteRadioIds = prefs
        .getStringList("favoriteRadioIds")
        ?.map((id) => int.parse(id))
        .toList()
        ?? [];

    return favoriteRadioIds;
  }

  // Future<List<RadioStation>> loadFavorites(List<RadioStation> radioList) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   for (RadioStation radio in radioList) {
  //     radio.isFavorite = prefs.getBool(radio.id.toString()) ?? false;
  //   }
  //   return radioList;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // headline (12% of body)
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          child: const Headline(),
        ),
        // filter options (15% of body)
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: const FilterOptions(),
        ),
        // radio list (32% of body)
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.50,
          child: const RadioList(),
        ),
        // fixed current Radio positioned at the bottom edge (10% of the body)
        const Expanded(
          child: CurrentRadio()),
      ],
    );
  }
}
