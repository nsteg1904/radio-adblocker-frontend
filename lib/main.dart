import 'package:get/get.dart';
import 'package:radio_adblocker/provider/theme_provider.dart';
import 'dart:io' show Platform;
import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:radio_adblocker/provider/filter_names_provider.dart';
import 'package:radio_adblocker/provider/filter_queries_provider.dart';
import 'package:radio_adblocker/screens/home/home.dart';
import 'package:radio_adblocker/screens/radio/radio.dart';
import 'package:radio_adblocker/screens/settings/settings.dart';
import 'package:radio_adblocker/services/client_data_storage_service.dart';
import 'package:radio_adblocker/services/websocket_api_service/websocket_radio_list_service.dart';
import 'package:radio_adblocker/services/websocket_api_service/websocket_radio_stream_service.dart';
import 'package:radio_adblocker/shared/colors.dart';
import 'package:radio_adblocker/shared/dependency_injection.dart';

import 'model/radio_station.dart';
import 'services/audio_player_radio_stream_service.dart';

Future<void> main() async {
  // This ensures that the initialization is complete before the app starts its execution.
  await WebSocketRadioListService.initChannel();
  await WebSocketRadioListService.requestRadioList(10);
  await WebSocketRadioStreamService.initChannel();

  WidgetsFlutterBinding.ensureInitialized();
  await WebSocketRadioStreamService.initStreamRequest();


  // Set the window size for Windows
  if (Platform.isWindows) {
    WindowManager.instance.setMaximumSize(const Size(400, 800));
    WindowManager.instance.setMinimumSize(const Size(400, 800));
    WindowManager.instance.setTitle('Radio Adblocker');
  }

  runApp(const RadioAdblocker());
  DependencyInjection.init();
}


class RadioAdblocker extends StatefulWidget {
  const RadioAdblocker({super.key});

  @override
  State<RadioAdblocker> createState() => _RadioAdblockerState();
}

class _RadioAdblockerState extends State<RadioAdblocker> {
  int _selectedIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Holds the current screen
    Widget page;
    //Switches the current screen
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


    return MultiProvider(
      providers: [
        StreamProvider<RadioStation?>.value(
          value: WebSocketRadioStreamService.getStreamableRadio(),
          initialData: null,
        ),
        StreamProvider<List<RadioStation>>.value(
          value: WebSocketRadioListService.getRadioList(),
          initialData: const [],
        ),
        ChangeNotifierProvider(
          create: (context) => FilterQueriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FilterNamesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lighttheme,
          darkTheme: darktheme,
          themeMode:  provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          title: 'Radio Adblocker',
          home: Scaffold(
            //to ensure the the body starts after the status bar-
            body: InitProvider(page: page),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
             backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              onTap: _onTabTapped,
              items:  const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home,),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.radio,),
                  label: 'Radio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings,),
                  label: 'Settings',
                ),
              ],
              selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            ),
          ),
        );
      },
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

  @override
  Widget build(BuildContext context) {

    final streamableRadio = Provider.of<RadioStation?>(context);
    AudioPlayerRadioStreamManager().setRadioSource(streamableRadio?.streamUrl);

    return SafeArea(
      child: widget.page,
    );
  }
}
