import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/provider/currentRadioProvider.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/currentRadio.dart';
import 'package:radio_adblocker/screens/home/filter/filter.dart';
import 'package:radio_adblocker/screens/home/headline.dart';
import 'package:radio_adblocker/screens/home/radioList/radioList.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState()  {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    List<RadioStation> radioList = [
      RadioStation.namedParameter(
        name: "Bremen Next",
        id: 1,
        streamUrl:
            "https://d141.rndfnk.com/ard/rb/bremennext/live/mp3/128/stream.mp3?aggregator=radio-de&cid=01FC1W7JCTNQQ1J99JMF830D6A&sid=2Y1b9thMIxZmsLRLd0mghxOAa5z&token=8L1rIdBMw4oYbnQchWphgKG6nsUqmvHaE517v0H_HQ8&tvf=Mlde_guclhdkMTQxLnJuZGZuay5jb20",
        logoUrl: "bremen_next.png",
        genres: ["EDM", "Techno", "Pop"],
        status: "add",
        song: Song.namedParameter(name: "Losing it", artists: ["FISHER"]),
      ),
      RadioStation(
          2,
          "1Live",
          "https://d131.rndfnk.com/ard/wdr/1live/live/mp3/128/stream.mp3?cid=01FBRZTS1K1TCD4KA2YZ1ND8X3&sid=2XyxxkD71majarUcdiEln8KVqD5&token=O5zzKPieNrNpT5ppgEZzveXFuIIey1t9mxLvQqwTC3M&tvf=V9C7UtFSlhdkMTMxLnJuZGZuay5jb20",
          "1Live.png",
          ["EDM", "Techno", "Pop"],
          "https://d131.rndfnk.com/ard/wdr/1live/live/mp3/128/stream.mp3?cid=01FBRZTS1K1TCD4KA2YZ1ND8X3&sid=2XyxxkD71majarUcdiEln8KVqD5&token=O5zzKPieNrNpT5ppgEZzveXFuIIey1t9mxLvQqwTC3M&tvf=V9C7UtFSlhdkMTMxLnJuZGZuay5jb20",
          Song("Losing it", ["FISHER"])),
      RadioStation(
        3,
        "WDR2",
        "https://d131.rndfnk.com/ard/wdr/wdr2/rheinland/mp3/64/stream.mp3?aggregator=radio-de&cid=01FBS03TJ7KW307WSY5W0W4NYB&sid=2Y1aSor0GIqmhSTTwZ8Zq0QewJ3&token=SqEhhntmIK61MhionZMTzRwWVWbS9UY29qgpghqQuDU&tvf=hzndCbyblhdkMTMxLnJuZGZuay5jb20",
        "wdr2.png",
        ["EDM", "Techno", "Pop"],
        "music",
        Song("Losing it", ["FISHER"]),
      ),
      RadioStation(
          4,
          "100,5 Hitradio",
          "https://dashitradio-stream26.radiohost.de/dashitradio_128?ref=radiode",
          "100_5_Hitradio.png",
          ["EDM", "Techno", "Pop"],
          "music",
          Song("Losing it", ["FISHER"])),
      RadioStation(
          5,
          "NDR2",
          "https://f131.rndfnk.com/ard/ndr/ndr2/niedersachsen/aac/64/stream.aac?aggregator=radio-de&cid=01FBQ2CWDYWJHGF4QAJ0SVV730&sid=2YD7gBUwRLayh8OYpst97SjILkk&token=BHZN-D06D0Zv588DYWO1hRac2JbxKYLgTXDjALCG4rY&tvf=uoKCg6nclxdmMTMxLnJuZGZuay5jb20",
          "ndr2.png",
          ["EDM", "Techno", "Pop"],
          "music",
          Song("Losing it", ["FISHER"])),
    ];
    final rList = await loadFavorites(radioList);

    //to ensure that the code is only called after the build phase
    Future.microtask(() {
      final currentRadioProvider = context.read<CurrentRadioProvider>();
      final filterRadioStationsProvider =
          context.read<FilterRadioStationsProvider>();
      final radioStationsProvider = context.read<RadioStationsProvider>();

      radioStationsProvider.changeRadioStationList(radios: rList);
      filterRadioStationsProvider.changeRadioStationList(radios: rList);

      currentRadioProvider.setRadio(radio: rList[0]);
      currentRadioProvider.setAudioStream(url: rList[0].streamUrl);
    });
  }

  Future<List<RadioStation>> loadFavorites(List<RadioStation> radioList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (RadioStation radio in radioList) {
      radio.isFavorite = prefs.getBool(radio.id.toString()) ?? false;
    }
    return radioList;
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
