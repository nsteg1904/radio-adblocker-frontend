import 'package:flutter/cupertino.dart';
import 'package:marquee/marquee.dart';

/// This class represents a text that scrolls automatically if it is too long.
/// It is used in [CurrentRadio] to display the current song.
/// It is also used in [RadioTile] to display the song.
class AutoScrollingText extends StatefulWidget {
  final String caller;
  final String text;
  final TextStyle style;

  const AutoScrollingText(
      {super.key, required this.text, required this.style, this.caller = ""});

  @override
  State<AutoScrollingText> createState() => _AutoScrollingTextState();
}

class _AutoScrollingTextState extends State<AutoScrollingText> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      /// This is the width of the container.
      double containerWidth = constraints.maxWidth;

      /// This is the width of the text.
      double textWidth = 0;

      /// This is the text painter.
      /// It is used to get the width of the text.
      /// This is necessary because the text is not rendered yet when the widget is built.
      TextPainter painter = TextPainter(
        text: TextSpan(
          text: widget.text,
          style: widget.style,
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textWidth = painter.width + 8.5; // to ensure that the text is not cut off

      if (textWidth > containerWidth) {
        return SizedBox(
          height: widget.style.fontSize! + 5,
          child: Marquee(
            text: widget.text,
            style: widget.style,
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 30.0,
            startPadding: 10.0,
            accelerationDuration: const Duration(seconds: 10),
            accelerationCurve: Curves.linear,
            decelerationDuration: const Duration(milliseconds: 2000),
            decelerationCurve: Curves.easeOut,
          ),
        );
      } else {
        return Text(
          widget.text,
          style: widget.style,
          maxLines: 1,
        );
      }
    });
  }
}
