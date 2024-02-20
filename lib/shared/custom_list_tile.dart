import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This class represents a custom list tile.
/// It is used in [RadioList] to display the radios.
/// It is also used in [CurrentRadio] to display the current radio.
class CustomListTile extends StatelessWidget {
  /// The widget that is displayed on the left side of the tile.
  final Widget leading;
  /// The widget that is displayed in the middle of the tile.
  final Widget title;
  /// The widget that is displayed below the title.
  final Widget? subtitle;
  /// The widget that is displayed on the right side of the tile.
  final Widget trailing;
  /// The widget that is displayed on the right side of the tile.
  final Widget? trailing2;
  /// The padding of the tile.
  final double padding;

  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    required this.trailing,
    this.trailing2,
    this.padding = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    // Check if there is a subtitle or a second trailing widget.
    bool hasSubtitle = subtitle != null;
    bool hasTrailing2 = trailing2 != null;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: LayoutBuilder(builder: (context, constraints) {
        // The width of the container.
        double containerWidth = constraints.maxWidth;

        // The height of the container is 17% of the width.
        double height = containerWidth * 0.17;

        // The width of the leading widget is 17% of the width.
        double leadingWidth = containerWidth * 0.17;

        // The width of the title is either 60% or 47% of the width, depending on whether there is a second trailing widget.
        double titleWidth = containerWidth * 0.47;

        // The width of the trailing widget is 13% of the width.
        double trailingWidth = hasTrailing2 ? containerWidth * 0.13 : containerWidth * 0.26;

        // The width of the gap between the widgets is 5% of the width.
        double gapWidth = containerWidth * 0.05;

        return Row(
          children: [
            SizedBox(
              width: leadingWidth,
              height: height,
              child: leading,
            ),
            SizedBox(
              width: gapWidth,
            ),
            // If there is a subtitle, the title and the subtitle are in a column.
            // Otherwise, the title is the full height of the container.
            Column(
              children: [
                SizedBox(
                  height: hasSubtitle ? height / 2 : height,
                  // If there is a subtitle, the title is half the height of the container.
                  width: titleWidth,
                  child: title,
                ),
                hasSubtitle
                    ? SizedBox(
                        height: height / 2,
                        width: titleWidth,
                        child: subtitle,
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              width: gapWidth,
            ),
            SizedBox(
              width: trailingWidth,
              height: height,
              child: trailing,
            ),

            // If there is a second trailing widget, it is displayed.
            hasTrailing2
                ? SizedBox(
                    width: trailingWidth,
                    height: height,
                    child: trailing2,
                  )
                : Container(),
          ],
        );
      }),
    );
  }
}
