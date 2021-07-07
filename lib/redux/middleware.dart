import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:locally/redux/Routes/navigation_action.dart';

import 'package:locally/redux/Routes/navigation_middleware.dart';

import 'package:locally/redux/appstate.dart';
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
              .navigateBackMiddleware())
    ];
  }
}