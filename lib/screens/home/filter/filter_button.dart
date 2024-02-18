import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/radio_station.dart';
import '../../../shared/colors.dart';

/// This class represents a filter button.
///
/// It is used in [FilterOptions] to display the filter buttons.
/// It contains the logic for changing the color of the button when it is pressed.
/// It takes the name of the button, the filter query, the method to run the filter and the filter queries as parameters.
class FilterButton extends StatefulWidget {
  /// The name of the button.
  final String name;
  ///The filter names.
  final List<String> filterNames;
  /// The method to provide the filter names.
  final Function(List<String> names) provideNames;

  /// The filter query.
  final bool Function(RadioStation) filterQuery;

  /// The method to run the filter.
  final Function(List<bool Function(RadioStation)>) runFilter;

  /// The filter queries.
  final List<bool Function(RadioStation)> filterQueries;

  const FilterButton(
      {super.key,
        required this.name,
        required this.filterQuery,
        required this.runFilter,
        required this.filterQueries,
        required this.filterNames,
        required this.provideNames});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  /// Whether the button is pressed or not.
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    /// Runs the Button Filter.
    ///
    /// The state of [isPressed] is changed.
    /// If [isPressed] is true, the parameter [FilterQuery] is added to the list [filerQueries] from the class [FilterOptions].
    /// If [isPressed] is false, the parameter [FilterQuery] is removed from the list [filerQueries] from the class [FilterOptions].
    /// The method [runFilter] from the class [FilterOptions] is called with the parameter [filterQueries].
    void runButtonFilter(bool Function(RadioStation) filterQuery) {
      setState(() => isPressed = !isPressed);

      if (isPressed) {
        widget.filterQueries.add(filterQuery);
        widget.runFilter(widget.filterQueries);

        widget.filterNames.add(widget.name);
        widget.provideNames(widget.filterNames);

      } else {
        widget.filterQueries.remove(filterQuery);
        widget.runFilter(widget.filterQueries);

        widget.filterNames.remove(widget.name);
        widget.provideNames(widget.filterNames);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8),
      child: ElevatedButton(
        onPressed: () => runButtonFilter(widget.filterQuery),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPressed ? Theme.of(context).colorScheme.onSecondary : Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          // visualDensity: const VisualDensity(vertical: 0),
        ),
        child: Text(
          widget.name,
          style: const TextStyle(
            color: defaultFontColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
