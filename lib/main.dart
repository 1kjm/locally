import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:locally/redux/appstate.dart';
import 'package:locally/redux/middleware.dart';
import 'package:locally/redux/reducers.dart';
import 'package:locally/screens/home_screen.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final store = Store<AppState>(reducer,
      initialState: AppState.initialState(),
      middleware: AppMiddleware(navigatorKey: navigatorKey).getMiddlewares());

  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          theme: store.state.customtheme,
          navigatorKey: navigatorKey,
          home: HomeScreen(
            key: key,
          ),
        ));
  }
}
