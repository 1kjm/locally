import 'package:locally/features/Navigation/redux/action.dart';
import 'package:locally/domain/redux/appstate.dart';

AppState navigatorReducer(AppState newState, action) {
  if (action is NavigateToNext) {
    newState.navigationState.activePages..add(action.destination);
  } else if (action is NavigateBack) {
    newState.navigationState.activePages..removeLast();
  }
  return newState;
}
