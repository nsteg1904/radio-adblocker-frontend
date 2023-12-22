import 'package:flutter/cupertino.dart';
import 'package:marquee/marquee.dart';

class AutoScrollingText extends StatefulWidget {
  final String caller;
  final String text;
  final TextStyle style;

  const AutoScrollingText({super.key, required this.text, required this.style, this.caller = ""});

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

      TextPainter painter = TextPainter(
        text: TextSpan(
          text: widget.text,
          style: widget.style,
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textWidth = painter.width + 8.5; // to ensure that the text is not cut off

      print('${widget.caller}: ContainerWidth: $containerWidth');
      print('${widget.caller}: textWidth: $textWidth');

      if (textWidth > containerWidth) {
        return SizedBox(
          height: 20,
          child: Marquee(
            text: widget.text,
            style: widget.style,
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 30.0,
            startPadding: 10.0,
            accelerationDuration: const Duration(seconds: 1),
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

// class _AutoScrollingTextState extends State<AutoScrollingText> {
//   @override
//   Widget build(BuildContext context) {
//     final globalKey = GlobalKey();
//     Widget? result;
//
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       if (globalKey.currentContext != null) {
//         double containerWidth =
//             (globalKey.currentContext?.findRenderObject() as RenderBox)
//                 .size
//                 .width;
//
//         /// This is the width of the text.
//         double textWidth = 0;
//
//         TextPainter painter = TextPainter(
//           text: TextSpan(
//             text: widget.text,
//             style: widget.style,
//           ),
//           textDirection: TextDirection.ltr,
//         )..layout();
//
//         textWidth = painter.width;
//
//         if (textWidth > containerWidth) {
//           setState(() {
//             result = SizedBox(
//               height: 20,
//               child: Marquee(
//                 text: widget.text,
//                 style: widget.style,
//                 scrollAxis: Axis.horizontal,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 blankSpace: 20.0,
//                 velocity: 30.0,
//                 startPadding: 10.0,
//                 accelerationDuration: const Duration(seconds: 1),
//                 accelerationCurve: Curves.linear,
//                 decelerationDuration: const Duration(milliseconds: 2000),
//                 decelerationCurve: Curves.easeOut,
//               ),
//             );
//           });
//         } else {
//           result = Text(
//             widget.text,
//             style: widget.style,
//           );
//         }
//
//         print('${widget.caller}: ContainerWidth: $containerWidth');
//         print('${widget.caller}: textWidth: $textWidth');
//       }
//     });
//
//     return Container(
//       key: globalKey,
//       child: result ?? Text("Hallo"),
//     );
//   }
// }
