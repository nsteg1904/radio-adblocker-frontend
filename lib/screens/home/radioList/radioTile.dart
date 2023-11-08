import 'package:flutter/material.dart';
import '../../../model/radioStation.dart';

class RadioTile extends StatelessWidget {
  final RadioStation radio;

  const RadioTile({super.key, required this.radio});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        color: const Color(0xff0b0b15),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/${radio.logoUrl}'),
          ),
          title: Text(
            radio.name,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            radio.song.name,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: Icon(
            Icons.favorite,
            color: radio.isFavorite ? Colors.red : const Color(0xff7b7b8b),
          ),
        ),
      ),
    );
  }
}
