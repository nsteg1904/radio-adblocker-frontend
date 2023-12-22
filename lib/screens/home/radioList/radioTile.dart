import 'package:flutter/material.dart';
import 'package:radio_adblocker/shared/custom_list_tile.dart';
import '../../../model/radioStation.dart';

import '../../../services/client_data_storage_service.dart';
import '../../../services/websocket_api_service/websocket_radio_stream_service.dart';
import '../../../shared/auto_scrolling_text.dart';
import '../../../shared/colors.dart';

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
    bool isFavorite =
    ClientDataStorageService().isFavoriteRadio(widget.radio.id);

    /// Toggles the favorite state of a radio station.
    void toggleFavorite() async {
      setState(() => widget.radio.isFavorite = !widget.radio.isFavorite);
      await ClientDataStorageService().safeFavoriteState(widget.radio.id);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () async {
          List<int> favIds =
          await ClientDataStorageService().loadFavoriteRadioIds();
          await WebSocketRadioStreamService.streamRequest(
              widget.radio.id, favIds);
          ClientDataStorageService().saveLastListenedRadio(widget.radio.id);
        },
        child: Card(
          margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          color: radioTileBackground,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CustomListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.radio.logoUrl,
                  fit: BoxFit.cover,
                ),
              ),
              title: AutoScrollingText(
                text: widget.radio.name,
                style: const TextStyle(
                  color: defaultFontColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: AutoScrollingText(
                text: '${widget.radio.song.artist} - ${widget.radio.song.name}',
                style: const TextStyle(
                  color: defaultFontColor,
                  fontSize: 12.0,
                ),
              ),
              trailing2: IconButton(
                onPressed: toggleFavorite,
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite
                      ? selectedFavIconColor
                      : unSelectedFavIconColor,
                ),
              ),
              trailing: Icon(
                widget.radio.status != "1" ? Icons.music_note : Icons.block,
                color: selectedElementColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
