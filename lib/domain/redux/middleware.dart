import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:locally/features/AutoCompleteTextField/data/redux/middleware.dart';
import 'package:locally/features/AutoCompleteTextField/data/redux/actions.dart';

import 'package:locally/data/contacts_data/actions.dart';
import 'package:locally/data/contacts_data/middleware.dart';

import 'package:locally/features/Navigation/redux/action.dart';

import 'package:locally/features/Navigation/redux/middleware.dart';

import 'package:locally/domain/redux/appstate.dart';

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
      TypedMiddleware<AppState, GetLocationIndex>(
          ActfMiddleWare().locationIndexMiddleware()),
    ];
  }
}
