import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:locally/redux/appstate.dart';

import 'package:locally/redux_store.dart';

import 'package:locally/screens/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    print('initial run');
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
            theme: store.state.customtheme,
            navigatorKey: navigatorKey,
            home: IntroScreen()));
  }
}
