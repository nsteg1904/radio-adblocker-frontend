import 'package:flutter/material.dart';
import '../../../model/radioStation.dart';

import '../../../services/client_data_storage_service.dart';
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

    bool isFavorite = ClientDataStorageService().isFavoriteRadio(widget.radio.id);

    /// Toggles the favorite state of a radio station.
    void toggleFavorite() async {
      setState(() => widget.radio.isFavorite = !widget.radio.isFavorite);
      await ClientDataStorageService().safeFavoriteState(widget.radio.id);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () async {
          List<int> favIds = await ClientDataStorageService().loadFavoriteRadioIds();
          await WebSocketRadioStreamService.streamRequest(widget.radio.id, favIds);
          ClientDataStorageService().saveLastListenedRadio(widget.radio.id);
        },
        child: Card(
          margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          color: const Color(0xff0b0b15),
          child: ListTile(
              //key: ValueKey(widget.radio.id),
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(widget.radio.logoUrl),
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
              trailing: ReorderableDragStartListener(
                index: widget.radio.id,
                child: const Icon(Icons.drag_handle),
          ),
          ),
        ),
      ),
    );
  }
}

// IconButton(
// onPressed: toggleFavorite,
// icon: Icon(
// Icons.favorite,
// color: isFavorite
// ? Colors.red
//     : const Color(0xff7b7b8b),
// ),
// )