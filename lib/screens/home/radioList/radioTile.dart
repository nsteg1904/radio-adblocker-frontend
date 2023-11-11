import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/radioStation.dart';
import '../../../provider/currentRadioProvider.dart';

class RadioTile extends StatefulWidget {
  final RadioStation radio;

  const RadioTile({super.key, required this.radio});

  @override
  State<RadioTile> createState() => _RadioTileState();
}

class _RadioTileState extends State<RadioTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () => context.read<CurrentRadioProvider>().setCurrentRadio(radio: widget.radio),
        child: Card(
          margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          color: const Color(0xff0b0b15),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage('assets/${widget.radio.logoUrl}'),
            ),
            title: Text(
              widget.radio.name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              widget.radio.song.name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: IconButton(
              onPressed: () => setState(() => widget.radio.isFavorite = !widget.radio.isFavorite),
              icon: Icon(
                Icons.favorite,
                color: widget.radio.isFavorite ? Colors.red : const Color(0xff7b7b8b),
              ),
            )
          ),
        ),
      ),
    );
  }
}
