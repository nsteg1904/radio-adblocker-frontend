import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/provider/filterRadioStationsProvider.dart';
import 'package:radio_adblocker/provider/radioStationsProvider.dart';
import 'package:radio_adblocker/screens/home/home.dart';
import 'package:radio_adblocker/screens/radio/radio.dart';
import 'package:radio_adblocker/screens/settings/settings.dart';
import 'package:radio_adblocker/services/client_data_storage_service.dart';
import 'package:radio_adblocker/services/websocket_api_service/websocket_radio_stream_service.dart';
import 'package:radio_adblocker/shared/colors.dart';

import 'model/radioStation.dart';
import 'services/audio_player_radio_stream_service.dart';

Future<void> main() async {
  // This ensures that the initialization is complete before the app starts its execution.
  await WebSocketRadioStreamService.initChannel();
  runApp(const RadioAdblocker());
}

class RadioAdblocker extends StatefulWidget {
  const RadioAdblocker({super.key});

  @override
  State<RadioAdblocker> createState() => _RadioAdblockerState();
}

class _RadioAdblockerState extends State<RadioAdblocker> {

  int _selectedIndex = 0;
  final Color _selectedColor = selectedElementColor;
  final Color _unselectedColor = unSelectedElementColor;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = const Home();
        break;
      case 1:
        page = const RadioScreen();
        break;
      case 2:
        page = const Settings();
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
    }

    return MaterialApp(
      title: 'Radio Adblocker',
      home: MultiProvider(
        providers: [
          StreamProvider<RadioStation?>.value(
              value: WebSocketRadioStreamService.getStreamableRadio(),
              initialData: null,
          ),
          ChangeNotifierProvider(
            create: (context) => FilterRadioStationsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => RadioStationsProvider(),
          ),
        ],
        child: Scaffold(
          backgroundColor: backgroundColor,
          //to ensure the the body starts after the status bar-
          body: InitProvider(page: page),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            backgroundColor: backgroundColor,
            onTap: _onTabTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.radio),
                label: 'Radio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            selectedItemColor: _selectedColor,
            unselectedItemColor: _unselectedColor,
          ),
        ),
      ),
    );
  }
}

class InitProvider extends StatefulWidget {
  final Widget page;
  const InitProvider({super.key, required this.page});

  @override
  State<InitProvider> createState() => _InitProviderState();
}

class _InitProviderState extends State<InitProvider> {

  Future<void> initStreamRequest() async {
    final prefService = ClientDataStorageService();
    int? lastListenedRadio = await prefService.loadLastListenedRadio();
    List<int> favoriteRadioIds = await prefService.loadFavoriteRadioIds();

    await WebSocketRadioStreamService.streamRequest(lastListenedRadio, favoriteRadioIds);
  }

  @override
  void initState() {
    initStreamRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final streamableRadio = Provider.of<RadioStation?>(context);
    AudioPlayerRadioStreamManager().setRadioSource(streamableRadio?.streamUrl);
    print('${streamableRadio?.id}, ${streamableRadio?.name}, ${streamableRadio?.streamUrl}, ${streamableRadio?.logoUrl}, ${streamableRadio?.genres}, ${streamableRadio?.status}, ${streamableRadio?.song.name}, ${streamableRadio?.song.artist}');


    return SafeArea(
      child: widget.page,
    );
  }
}

