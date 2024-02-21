import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final double size;
  final Function func;
  final Icon icon;

  const SkipButton(
      {super.key, required this.size, required this.func, required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 27.0 * size, // to scale Widget size
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: IconButton(
        icon: icon,
        iconSize: 35 * size,
        color: Theme.of(context).colorScheme.onBackground,
        onPressed: () async {
          await func();
        },
      ),
    );
  }
}
