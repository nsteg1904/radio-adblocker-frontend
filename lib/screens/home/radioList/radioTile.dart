import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/radioStation.dart';
import '../../../provider/currentRadioProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    /// The currently selected radio station.
    final currentRadioProvider = context.read<CurrentRadioProvider>();

    /// Saves the favorite state of a radio station.
    ///
    /// This method is called in [toggleFavorite].
    /// It takes [id] and [favorite] as parameters.
    /// It uses the [SharedPreferences] package to persist the favorites.
    /// It saves the favorites in the [SharedPreferences] with the key [id]
    /// and the value [favorite].
    void safeFavoriteState(int id, bool favorite) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool(id.toString(), favorite);
    }

    /// Toggles the favorite state of a radio station.
    void toggleFavorite() {
      setState(() => widget.radio.isFavorite = !widget.radio.isFavorite);
      safeFavoriteState(widget.radio.id, widget.radio.isFavorite);
    }

    void saveLastListenedRadio(int id) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('lastListenedRadio',id);
    }


    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () {
          currentRadioProvider.setCurrentRadio(radio: widget.radio);
          // Speichere die ID der zuletzt gehörten Radio-Station
          saveLastListenedRadio(widget.radio.id);
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
                color: widget.radio.isFavorite ? Colors.red : const Color(0xff7b7b8b),
              ),
            )
          ),
        ),
      ),
    );
  }
}
