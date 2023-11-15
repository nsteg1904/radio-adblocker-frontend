import 'package:flutter/material.dart';
import 'package:radio_adblocker/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingState();
}

class _SettingState extends State<Settings>{
  bool switchValue1 = false;
  bool switchValue2 = false;
  bool switchValue3 = false;

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
                value: switchValue1,
                onChanged: (bool value) {
                  setState(() {
                    switchValue1 = value;
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
                value: switchValue2,
                onChanged: (bool value) {
                  setState(() {
                    switchValue2 = value;
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
                value: switchValue3,
                onChanged: (bool value) {
                  setState(() {
                    switchValue3 = value;
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
    prefs.setBool('switch1', switchValue1);
    prefs.setBool('switch2', switchValue2);
    prefs.setBool('switch3', switchValue3);
  }
  void loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      switchValue1 = prefs.getBool('switch1') ?? false;
      switchValue2 = prefs.getBool('switch2') ?? false;
      switchValue3 = prefs.getBool('switch3') ?? false;
    });
  }
}




