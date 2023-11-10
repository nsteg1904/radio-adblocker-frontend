import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/radioStation.dart';
import '../../../shared/colors.dart';

class FilterButton extends StatefulWidget {
  final String name;
  final bool Function(RadioStation) filterQuery;
  final Function(List<bool Function(RadioStation)>) runFilter;
  final List<bool Function(RadioStation)> filterQueries;

  const FilterButton({super.key, required this.name, required this.filterQuery, required this.runFilter, required this.filterQueries});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {

    void runButtonFilter(bool Function(RadioStation) filterQuery) {
      setState(() => isPressed = !isPressed);

      if(isPressed){
        widget.filterQueries.add(filterQuery);
        widget.runFilter(widget.filterQueries);
      } else {
        widget.filterQueries.remove(filterQuery);
        widget.runFilter(widget.filterQueries);
      }

    }

    return  ElevatedButton(
      onPressed: () => runButtonFilter(widget.filterQuery),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPressed
            ? selectedElementColor
            : areaColor,
      ),
      child: Text(widget.name),
    );
  }
}