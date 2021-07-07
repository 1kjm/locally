import 'package:locally/redux/Routes/navigation_action.dart';
import 'package:locally/redux/appstate.dart';

AppState navigatorReducer(AppState newState, action) {
  if (action is NavigateToNext) {
    newState.navigationState.activePages..add(action.destination);
  } else if (action is NavigateBack) {
    newState.navigationState.activePages..removeLast();
  }
  return newState;
}
