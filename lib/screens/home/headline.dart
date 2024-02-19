import 'package:flutter/cupertino.dart';
import 'package:radio_adblocker/shared/colors.dart';
import 'package:radio_adblocker/provider/theme_provider.dart';
import 'package:flutter/material.dart';
/// This class represents the headline of the home screen.
///
/// It is used in [Home] to display the headline.
class Headline extends StatelessWidget {
  const Headline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:  Text(
        'Home',
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}
