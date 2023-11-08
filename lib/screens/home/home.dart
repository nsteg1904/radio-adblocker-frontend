import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

    context.read<RadioStationsProvider>().changeRadioStationList(radios: radioList); //get all available  radios
    context.read<FilterRadioStationsProvider>().changeRadioStationList(radios: radioList); //get all available radios
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // headline (12% of body)
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              child: const Headline(),
            ),
            // filter options (20% of body)
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: FilterOptions(),
            ),
            // radio list (32% of body)
            Expanded(
              child: Container(
                child: const RadioList(),
              ),
            ),
          ],
        ),
        // fixed current Radio positioned at the bottom edge (8% of the body)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.08,
              child: const CurrentRadio()),
        ),
      ],
    );
  }
}
