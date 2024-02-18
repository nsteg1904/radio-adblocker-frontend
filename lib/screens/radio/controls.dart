import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/radio_station.dart';
import '../../services/client_data_storage_service.dart';
import '../../services/websocket_api_service/websocket_radio_stream_service.dart';
import '../../shared/colors.dart';
import '../../shared/radio_stream_control_button.dart';

///Displays the control buttons to navigate between Radios and Play / Pause.
class Controls extends StatefulWidget {
  static const double size = 2;
  const Controls({super.key});

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    //Request next Radio
    void nextRadio() async {
      List<int> favIds = await ClientDataStorageService().loadFavoriteRadioIds();
      final int currentRadioId = Provider.of<RadioStation?>(context, listen: false)!.id;
      //Get List of all Radios
      final List<RadioStation> radioList = Provider.of<List<RadioStation>>(context, listen: false);
      //Get the index of the current Radio in the List
      final int currentRadioIndex = radioList.indexWhere((element) => element.id == currentRadioId);
      await WebSocketRadioStreamService.streamRequest(radioList[(currentRadioIndex + 1) % radioList.length].id, favIds);
    }

    //Request previous Radio
    void previousRadio() async {
      final int currentRadioId = Provider.of<RadioStation?>(context, listen: false)!.id;
      //Get List of all Radios
      final List<RadioStation> radioList = Provider.of<List<RadioStation>>(context, listen: false);
      //Get the index of the current Radio in the List
      final int currentRadioIndex = radioList.indexWhere((element) => element.id == currentRadioId);
      List<int> favIds = await ClientDataStorageService().loadFavoriteRadioIds();
      await WebSocketRadioStreamService.streamRequest(radioList[(currentRadioIndex - 1) % radioList.length].id, favIds);
    }

    //Returns
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
            radius: 27.0 * Controls.size, // to scale Widget size
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: IconButton(
              icon: const Icon(Icons.skip_previous),
              iconSize: 35 * Controls.size,
              color: Theme.of(context).colorScheme.onBackground,
              onPressed: () {
                previousRadio();
              },
            )
        ),
        const RadioStreamControlButton(
          //gives the size of widget as a parameter to scale the widget
          size: Controls.size,
        ),
        CircleAvatar(
            radius: 27.0 * Controls.size, // to scale Widget size
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: IconButton(
              icon: const Icon(Icons.skip_next,),
              iconSize: 35 * Controls.size,
              color: Theme.of(context).colorScheme.onBackground,
              onPressed: () {
                nextRadio();
              },
            )
        ),
      ],);
  }
}