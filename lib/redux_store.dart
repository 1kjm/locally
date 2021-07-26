import 'package:locally/main.dart';
import 'package:locally/redux/appstate.dart';
import 'package:locally/redux/middleware.dart';
import 'package:locally/redux/reducers.dart';
import 'package:redux/redux.dart';

final store = Store<AppState>(reducer,
    initialState: AppState.initialState(),
    middleware: AppMiddleware(navigatorKey: navigatorKey).getMiddlewares());
