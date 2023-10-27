import 'package:flutter/cupertino.dart';
import 'package:radio_adblocker/model/song.dart';
import 'package:radio_adblocker/screens/home/radioList/radioTile.dart';
import '../../../model/radioStation.dart';


class RadioList extends StatefulWidget {
  const RadioList({super.key});

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  List<RadioStation> radioList = [
    RadioStation.namedParameter(name: "1Live", url: "asdf", image: "1Live.png", genres: ["EDM", "Techno", "Pop"], status: "music", song: Song.namedParameter(name: "Losing it",artists: ["FISHER"])),
    RadioStation("1Live", "asdf", "1Live.png", ["EDM", "Techno", "Pop"], "music", Song("Losing it",["FISHER"])),
    RadioStation("WDR2", "asdf", "wdr2.png", ["EDM", "Techno", "Pop"], "music", Song("Losing it",["FISHER"])),
    RadioStation("100,5 Hitradio", "asdf", "100_5_Hitradio.png",["EDM", "Techno", "Pop"], "music", Song("Losing it",["FISHER"])),
    RadioStation("NDR2", "asdf", "ndr2.png", ["EDM", "Techno", "Pop"], "music", Song("Losing it",["FISHER"])),
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: radioList.length,
      itemBuilder: (context, index) {
        return RadioTile(radio: radioList[index]);
      },
    );
  }
}
