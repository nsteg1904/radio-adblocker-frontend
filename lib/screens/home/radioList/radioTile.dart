import 'package:flutter/material.dart';
import '../../../model/radioStation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/websocket_api_service/websocket_radio_stream_service.dart';

/// This class represents a radio tile.
///
/// It is used in [RadioList] to display a radio tile.
class RadioTile extends StatefulWidget {
  /// The radio station that is displayed in the tile.
  final RadioStation radio;

  const RadioTile({super.key, required this.radio});

  @override
  State<RadioTile> createState() => _RadioTileState();
}

class _RadioTileState extends State<RadioTile> {
  @override
  Widget build(BuildContext context) {

    /// Saves the favorite state of a radio station.
    ///
    /// This method is called in [toggleFavorite].
    /// It takes [radioId] as parameter.
    /// It uses the [SharedPreferences] package to persist the favorites..
    void safeFavoriteState(int radioId) async {
      String id = radioId.toString();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favorites = prefs.getStringList("favoriteRadioIds") ?? [];

      favorites.contains(id) ? favorites.remove(id) : favorites.add(id);


      prefs.setStringList("favoriteRadioIds", favorites);
    }

    /// Toggles the favorite state of a radio station.
    void toggleFavorite() {
      setState(() => widget.radio.isFavorite = !widget.radio.isFavorite);
      safeFavoriteState(widget.radio.id);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () async {
          // Change the current radio station.
          await WebSocketRadioStreamService.streamRequest(widget.radio.id, []);
          // currentRadioProvider.setCurrentRadio(radio: widget.radio);
        },
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
                onPressed: toggleFavorite,
                icon: Icon(
                  Icons.favorite,
                  color: widget.radio.isFavorite
                      ? Colors.red
                      : const Color(0xff7b7b8b),
                ),
              )),
        ),
      ),
    );
  }
}
