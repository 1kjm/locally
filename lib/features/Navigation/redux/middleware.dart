import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:locally/features/Navigation/animation/navigation_animation.dart';
import 'package:locally/features/Navigation/redux/utils/route_converter.dart';

import 'package:locally/domain/redux/appstate.dart';
import 'package:redux/redux.dart';

class NavigationMiddleware {
  final GlobalKey<NavigatorState> navigatorKey;
  final DestinationToWidgetConverter _destinationToWidgetConverter =
      DestinationToWidgetConverter();
  NavigationMiddleware({required this.navigatorKey});

  Middleware<AppState> navigateToNextMiddleware() {
    return (Store<AppState> store, action, NextDispatcher next) {
      print('navigation_middleware NavigateNEXT ' +
          store.state.navigationState.activePages.length.toString());
      final currentDestination = action.destination;
      navigatorKey.currentState!.push(NavigationAnimation(
              pageRouteName:
                  _destinationToWidgetConverter.convert(currentDestination))
          .createRoute());
      next(action);
    };
  }

  Middleware<AppState> navigateBackMiddleware() {
    return (Store<AppState> store, action, NextDispatcher next) {
      print('navigation_middleware NavigateBACK ' +
          store.state.navigationState.activePages.length.toString());
      final currentActivePages = store.state.navigationState.activePages;
      if (currentActivePages.length == 1) {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }

      navigatorKey.currentState!.pop();
      next(action);
    };
  }
}
