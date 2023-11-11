import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/provider/currentRadioProvider.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/currentRadio.dart';
import 'package:radio_adblocker/screens/home/filter/filter.dart';
import 'package:radio_adblocker/screens/home/headline.dart';
import 'package:radio_adblocker/screens/home/radioList/radioList.dart';

import '../../model/radioStation.dart';
import '../../model/song.dart';
import '../../provider/radioStationsProvider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    List<RadioStation> radioList = [
      RadioStation.namedParameter(name: "Bremen Next", streamUrl: "asdf", logoUrl: "bremen_next.png", genres: ["EDM", "Techno", "Pop"], status: "add", song: Song.namedParameter(name: "Losing it",artists: ["FISHER"]), isFavorite: true),
      RadioStation("1Live", "asdf", "1Live.png", ["EDM", "Techno", "Pop"], "music", Song("Losing it",["FISHER"])),
      RadioStation("WDR2", "asdf", "wdr2.png", ["EDM", "Techno", "Pop"], "music", Song("Losing it",["FISHER"]),isFavorite: true),
      RadioStation("100,5 Hitradio", "asdf", "100_5_Hitradio.png",["EDM", "Techno", "Pop"], "music", Song("Losing it",["FISHER"])),
      RadioStation("NDR2", "asdf", "ndr2.png", ["EDM", "Techno", "Pop"], "music", Song("Losing it",["FISHER"])),
    ];

    //to ensure that the code is only called after the build phase
    Future.microtask(() {
      context.read<RadioStationsProvider>().changeRadioStationList(radios: radioList);
      context.read<FilterRadioStationsProvider>().changeRadioStationList(radios: radioList);
      context.read<CurrentRadioProvider>().setCurrentRadio(radio: radioList[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
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
            const Expanded(
              child: RadioList(),
            ),
          ],
        ),
        // fixed current Radio positioned at the bottom edge (10% of the body)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: const CurrentRadio()),
        ),
      ],
    );
  }
}
