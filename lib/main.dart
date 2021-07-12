import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/redux/Firestore/firestore_actions.dart';
import 'package:locally/redux/appstate.dart';
import 'package:locally/redux/middleware.dart';
import 'package:locally/redux/reducers.dart';
import 'package:locally/screens/home_screen.dart';
import 'package:locally/screens/intro_screen.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final store = Store<AppState>(reducer,
      initialState: AppState.initialState(),
      middleware: AppMiddleware(navigatorKey: navigatorKey).getMiddlewares());

  Widget build(BuildContext context) {
    store.dispatch(GetDataFromFirestore());

    print('initial run');
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
            theme: store.state.customtheme,
            navigatorKey: navigatorKey,
            home: FutureBuilder(
              future: store.state.initialRunCheckState.isInitialRun,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Scaffold(
                        body: Container(child: CircularProgressIndicator()));
                  default:
                    if (!snapshot.hasError) {
                      return snapshot.data! ? IntroScreen() : HomeScreen();
                    } else
                      print('error in snapshot');
                    return IntroScreen();
                }
              },
            )));
  }
}
