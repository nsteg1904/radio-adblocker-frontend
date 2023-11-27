import 'package:flutter/material.dart';
import 'package:radio_adblocker/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingState();
}

class _SettingState extends State<Settings>{
  bool dunkelModus = false;
  bool nachrichten = false;
  bool werbung = false;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 24.0),
          const Padding(
            padding: EdgeInsets.only(left: 8.0), // Added padding to shift the text
            child: Text(
              'Settings',
              style: TextStyle(
                color: defaultFontColor,
                fontSize: 38.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 75.0),
          Row(
            children: <Widget>[
              const Icon(Icons.light_mode),
              const SizedBox(width: 8.0),
              const Text(
                'Dunkel/Hell',
                style: TextStyle(color: Colors.grey ,fontSize: 20.0),
              ),
              const Spacer(),
              Switch(
                activeColor: selectedElementColor,
                activeTrackColor: unSelectedElementColor,
                inactiveTrackColor:Colors.grey[850],
                inactiveThumbColor: Colors.grey[700],
                value: dunkelModus,
                onChanged: (bool value) {
                  setState(() {
                    dunkelModus = value;
                    saveSettings();
                  });
                },
              ),
            ],
          ),
          const Divider(height: 20,color: Colors.black38,thickness: 0.5),
          Row(
            children: <Widget>[
              const Icon(Icons.block),
              const SizedBox(width: 8.0),
              const Text(
                'Nachrichten',
                style: TextStyle(color: Colors.grey ,fontSize: 20.0),
              ),
              const Spacer(),
              Switch(
                activeColor: selectedElementColor,
                activeTrackColor: unSelectedElementColor,
                inactiveTrackColor:Colors.grey[850],
                inactiveThumbColor: Colors.grey[700],
                value: nachrichten,
                onChanged: (bool value) {
                  setState(() {
                    nachrichten = value;
                    saveSettings();
                  });
                },
              ),
            ],
          ),
          const Divider(height: 20,color: Colors.black38,thickness: 0.5,),
          Row(
            children: <Widget>[
              const Icon(Icons.block),
              const SizedBox(width: 8.0),
              const Text(
                'Werbung',
                style: TextStyle(color: Colors.grey ,fontSize: 20.0),

              ),
              const Spacer(),
              Switch(
                activeColor: selectedElementColor,
                activeTrackColor: unSelectedElementColor,
                inactiveTrackColor:Colors.grey[850],
                inactiveThumbColor: Colors.grey[700],
                value: werbung,
                onChanged: (bool value) {
                  setState(() {
                    werbung = value;
                    saveSettings();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  void saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switch1', dunkelModus);
    prefs.setBool('switch2', nachrichten);
    prefs.setBool('switch3', werbung);
  }
  void loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dunkelModus = prefs.getBool('switch1') ?? false;
      nachrichten = prefs.getBool('switch2') ?? false;
      werbung = prefs.getBool('switch3') ?? false;
    });
  }
}




