import 'package:flutter/material.dart';
import 'package:radio_adblocker/shared/custom_list_tile.dart';
import 'dart:io' show Platform;
import '../../../model/radioStation.dart';
import '../../../services/audio_player_radio_stream_service.dart';
import '../../../shared/colors.dart';
import '../../../services/client_data_storage_service.dart';
import '../../../services/websocket_api_service/websocket_radio_stream_service.dart';

/// This class represents a radio tile.
///
/// It is used in [RadioList] to display a radio tile.
class RadioTile extends StatefulWidget {
  /// The radio station that is displayed in the tile.
  final RadioStation radio;
  final bool reorderable;

  const RadioTile({super.key, required this.radio, required this.reorderable});

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

    Widget trailing2() {
      if (widget.reorderable) {
        return ReorderableDragStartListener(
          index: widget.radio.id,
          child: const Icon(Icons.drag_handle, color: Colors.white),
        );
      }
      else {
        return IconButton(
          onPressed: toggleFavorite,
          icon: Icon(
            Icons.favorite,
            color: isFavorite
                ? selectedFavIconColor
                : unSelectedFavIconColor,
          ),
        );
      }
    }

    /// Shows a dialog if the radio station is currently playing an ad.
    void showRadioStationDialog() async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 5), () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(true);
            }
          });
          return AlertDialog(
            backgroundColor: backgroundColor ,
            title: Text(
              widget.radio.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Es läuft gerade Werbung auf diesem Sender und kann deshalb nicht abgespielt werden.',
              style: TextStyle(
                color: defaultFontColor,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: selectedElementColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () async {
          // Load favorite radio ids
          List<int> favIds =
          await ClientDataStorageService().loadFavoriteRadioIds();

          // Request the radio stream
          await WebSocketRadioStreamService.streamRequest(
              widget.radio.id, favIds);

          AudioPlayerRadioStreamManager streamManager = AudioPlayerRadioStreamManager();

          if(Platform.isWindows) {
            await streamManager.stopRadio();
            await streamManager.setRadioSource(widget.radio.streamUrl);

            // Needs to be delayed so it works on windows as well (don't touch) (but doesn't work all the time)
            Future.delayed(const Duration(milliseconds: 1500), () async {
              await streamManager.playRadio();
            });
          } else {
            await streamManager.playRadio();
          }


          // Save the last listened radio
          ClientDataStorageService().saveLastListenedRadio(widget.radio.id);

          if (widget.radio.status == "1") {
            showRadioStationDialog();
          }
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
              title: Text (
                widget.radio.name,
                style: const TextStyle(
                  color: defaultFontColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                '${widget.radio.song.name} - ${widget.radio.song.artist}',
                style: const TextStyle(
                  color: defaultFontColor,
                  fontSize: 12.0,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // AutoScrollingText(
              //   text: '${widget.radio.song.artist} - ${widget.radio.song.name}',
              //   style: const TextStyle(
              //     color: defaultFontColor,
              //     fontSize: 12.0,
              //   ),
              // ),
              trailing2: trailing2(),
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
