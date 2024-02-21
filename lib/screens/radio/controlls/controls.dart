import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/screens/radio/controlls/skip_button.dart';

import '../../../model/radio_station.dart';
import '../../../services/client_data_storage_service.dart';
import '../../../services/websocket_api_service/websocket_radio_stream_service.dart';
import '../../../shared/radio_stream_control_button.dart';

///Displays the control buttons to navigate between Radios and Play / Pause.
class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    final int? currentRadioId = Provider.of<RadioStation?>(context)?.id;
    //Get List of all Radios
    final List<RadioStation> radioList =
        Provider.of<List<RadioStation>>(context);

    final double size = 2;

    //Returns the next radio in the list of radios
    void nextRadio() async {
      List<int> favIds =
          await ClientDataStorageService().loadFavoriteRadioIds();

      //Get the index of the current Radio in the List
      final int currentRadioIndex =
          radioList.indexWhere((element) => element.id == currentRadioId);
      await WebSocketRadioStreamService.streamRequest(
          radioList[(currentRadioIndex + 1) % radioList.length].id, favIds);
    }

    //Request the previous radio in the list of radios
    void previousRadio() async {
      //Get the index of the current Radio in the List
      final int currentRadioIndex =
          radioList.indexWhere((element) => element.id == currentRadioId);
      List<int> favIds =
          await ClientDataStorageService().loadFavoriteRadioIds();
      await WebSocketRadioStreamService.streamRequest(
          radioList[(currentRadioIndex - 1) % radioList.length].id, favIds);
    }

    //Returns the control buttons to navigate between Radios and Play / Pause.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SkipButton(
          icon: const Icon(
            Icons.skip_previous_outlined,
          ),
          size: size,
          func: previousRadio,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xfff12121a).withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 6), // changes position of shadow
              ),
            ],
            shape: BoxShape.circle,
          ),
          child: RadioStreamControlButton(
            //gives the size of widget as a parameter to scale the widget
            size: size,
            color: const Color(0xfff191925),
          ),
        ),
        SkipButton(
          icon: const Icon(
            Icons.skip_next_outlined,
          ),
          size: size,
          func: nextRadio,
        ),
      ],
    );
  }
}
