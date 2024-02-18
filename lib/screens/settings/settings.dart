import 'package:flutter/material.dart';
import 'package:radio_adblocker/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:radio_adblocker/provider/theme_provider.dart';
import 'package:provider/provider.dart';
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingState();
}

class _SettingState extends State<Settings>{
  bool dunkelModus = false;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 24.0),
           Padding(
            padding: EdgeInsets.only(left: 8.0), // Added padding to shift the text
            child: Text(
              'Settings',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
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
               Text(
                'Dunkel/Hell',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary ,fontSize: 20.0),
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
                    provider.toggleTheme();
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
  }
  void loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dunkelModus = prefs.getBool('switch1') ?? false;
    });
  }
}




