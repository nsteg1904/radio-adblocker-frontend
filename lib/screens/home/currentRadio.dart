import 'package:flutter/cupertino.dart';

class CurrentRadio extends StatefulWidget {
  const CurrentRadio({super.key});

  @override
  State<CurrentRadio> createState() => _CurrentRadioState();
}

class _CurrentRadioState extends State<CurrentRadio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff2d2c3c),
        child: const Text('Aktuelles Radio'));
  }
}
