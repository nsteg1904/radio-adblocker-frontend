import 'package:flutter/cupertino.dart';
import 'package:radio_adblocker/shared/colors.dart';

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
