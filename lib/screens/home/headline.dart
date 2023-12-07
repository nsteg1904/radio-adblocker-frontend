import 'package:flutter/cupertino.dart';
import 'package:radio_adblocker/shared/colors.dart';

/// This class represents the headline of the home screen.
///
/// It is used in [Home] to display the headline.
class Headline extends StatelessWidget {
  const Headline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text(
        'Home',
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: defaultFontColor,
        ),
      ),
    );
  }
}
