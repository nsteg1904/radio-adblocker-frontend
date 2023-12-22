import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget? subtitle;
  final Widget trailing;
  final Widget? trailing2;

  const CustomListTile({super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    required this.trailing,
    this.trailing2});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
          builder: (context, constraints) {
            double containerWidth = constraints.maxWidth;

            double height = containerWidth * 0.17;

            double leadingWidth = containerWidth * 0.17;
            double titleWidth = containerWidth * 0.47;
            double trailingWidth = containerWidth * 0.13;
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
                Column(
                  children: [
                    Container(
                      height: height / 2,
                      width: titleWidth,
                      color: Colors.blue,
                      child: title,
                    ),
                    Container(
                      height: height / 2,
                      width: titleWidth,
                      color: Colors.green,
                      child: subtitle,
                    )
                  ],
                ),
                SizedBox(
                  width: gapWidth,
                ),
                Container(
                  width: trailingWidth,
                  height: height,
                  color: Colors.orange,
                  child: trailing,
                ),
                Container(
                  width: trailingWidth,
                  height: height,
                  color: Colors.orange,
                  child: trailing2,
                ),
                // Expanded(child: trailing2 == null ? Container() : trailing2!),
              ],
            );
          }

      ),
    );
  }
}
