import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:locally/features/actf_redux_actions.dart';
import 'package:locally/features/actf_middleware.dart';
import 'package:locally/redux/Firestore/firestore_actions.dart';
import 'package:locally/redux/Firestore/firestore_middleware.dart';
import 'package:locally/redux/Routes/navigation_action.dart';

import 'package:locally/redux/Routes/navigation_middleware.dart';

import 'package:locally/redux/appstate.dart';

import 'package:locally/redux/initialRunChecker/initial_run_check_actions.dart';
import 'package:locally/redux/initialRunChecker/initial_run_check_middlewares.dart';
import 'package:redux/redux.dart';

class AppMiddleware {
  final GlobalKey<NavigatorState> navigatorKey;
  AppMiddleware({required this.navigatorKey});
  List<Middleware<AppState>> getMiddlewares() {
    return [
      TypedMiddleware<AppState, NavigateToNext>(
          NavigationMiddleware(navigatorKey: navigatorKey)
              .navigateToNextMiddleware()),
      TypedMiddleware<AppState, NavigateBack>(
          NavigationMiddleware(navigatorKey: navigatorKey)
              .navigateBackMiddleware()),
      TypedMiddleware<AppState, GetDataFromFirestore>(
        FirestoreMiddleWare().firebaseFirestoreMiddleware(),
      ),
      TypedMiddleware<AppState, ChangeInitialRunCheckValue>(
          InitialRunCheckMiddleWare().setValueOfInitialRunMiddleware()),
      TypedMiddleware<AppState, GetLocationIndex>(
          ActfMiddleWare().locationIndexMiddleware()),
    ];
  }
}
