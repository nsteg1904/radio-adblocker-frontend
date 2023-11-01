import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/radioStation.dart';
import '../../../provider/filterRadioStationsProvider.dart';
import '../../../shared/colors.dart';

class FilterButton extends StatefulWidget {
  final String name;
  final bool Function(RadioStation) filterQuery;
  final List<RadioStation> radios;
  final List<RadioStation> filterRadios;

  const FilterButton({super.key, required this.name, required this.filterQuery, required this.radios, required this.filterRadios});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {

    void setRadioStations(List<RadioStation> foundRadios) {
      context
          .read<FilterRadioStationsProvider>()
          .changeRadioStationList(radios: foundRadios);
    }

    List<RadioStation> runListFilter(bool Function(RadioStation) filterQuery) {
      return widget.filterRadios.where(filterQuery).toList();
    }

    void runButtonFilter(bool Function(RadioStation) filterQuery) {
      setState(() => isPressed = !isPressed);

      isPressed
          ? setRadioStations(runListFilter(filterQuery)) //set Favorites
          : setRadioStations(widget.radios); //reset filter
    }

    return  ElevatedButton(
      onPressed: () => runButtonFilter(widget.filterQuery),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPressed
            ? selectedElementColor
            : buttonColor,
      ),
      child: Text(widget.name),
    );
  }
}