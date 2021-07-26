import 'package:locally/features/actf_redux_actions.dart';
import 'package:locally/redux/appstate.dart';

AppState locationDataFromFirestore(AppState newState, action) {
  if (action is StoreLocationIndex) {
    newState.locationIndex = action.payload;
    newState.hasLocationIndexData = Future.value(action.hasDataFlag);
  }
  return newState;
}