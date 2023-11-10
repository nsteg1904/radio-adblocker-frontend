import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio_adblocker/shared/audioButton.dart';
import 'package:radio_adblocker/shared/colors.dart';

class CurrentRadio extends StatefulWidget {
  const CurrentRadio({super.key});

  @override
  State<CurrentRadio> createState() => _CurrentRadioState();
}

class _CurrentRadioState extends State<CurrentRadio> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff1d1d30),
      child: ListTile(
        // dense: true,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/bremen_next.png',
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
        ),

        title: const Text(
          'Losing it',
          style: TextStyle(color: defaultFontColor),
        ),
        subtitle: const Text(
          'FISHER',
          style: TextStyle(color: defaultFontColor),
        ),
        trailing: const AudioButton(),
      ),
    );
  }
}
