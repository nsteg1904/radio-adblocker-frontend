import 'package:flutter/material.dart';
import 'package:radio_adblocker/screens/home/currentRadio.dart';
import 'package:radio_adblocker/screens/home/filter.dart';
import 'package:radio_adblocker/screens/home/headline.dart';
import 'package:radio_adblocker/screens/home/radiolist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // headline (12% of body)
            Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.12,
              child: const Headline(),
            ),
            // filter options (20% of body)
            Container(
              color: Colors.green,
              height: MediaQuery.of(context).size.height * 0.2,
              child: const FilterOptions(),
            ),
            // radio list (32% of body)
            Expanded(
              child: Container(
                color: Colors.orange,
                child: const RadioList(),
              ),
            ),
          ],
        ),
        // fixed current Radio positioned at the bottom edge (8% of the body)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.red,
            height: MediaQuery.of(context).size.height * 0.08,
            child: const CurrentRadio()
          ),
        ),
      ],
    );
  }
}
