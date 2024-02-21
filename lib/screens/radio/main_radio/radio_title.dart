import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio_adblocker/model/radio_station.dart';

import '../../../services/client_data_storage_service.dart';
import '../../../shared/colors.dart';

class Radiotitle extends StatelessWidget {
  final RadioStation currentRadio;

  const Radiotitle({super.key, required this.currentRadio});

  @override
  Widget build(BuildContext context) {
    bool isFavorite =
        ClientDataStorageService().isFavoriteRadio(currentRadio.id);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentRadio.name,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            Icons.favorite,
            color: isFavorite ? selectedFavIconColor : unSelectedFavIconColor,
            size: 45,
          ),
        ],
      ),
    );
  }
}
