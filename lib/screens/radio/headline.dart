import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio_adblocker/model/radio_station.dart';

import '../../services/client_data_storage_service.dart';
import '../../shared/colors.dart';

class Headline extends StatelessWidget {
  final RadioStation? currentRadio;

  const Headline({super.key, required this.currentRadio});

  @override
  Widget build(BuildContext context) {
    bool isFavorite = ClientDataStorageService().isFavoriteRadio(currentRadio!.id);

    return Container(
      color: Colors.blue,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Center(
        child: Row(
          children: [
            Text(
              currentRadio!.name,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            Icon(
              Icons.favorite,
              color: isFavorite ? selectedFavIconColor : unSelectedFavIconColor,
            ),
          ],
        ),
      ),
    );
  }
}
