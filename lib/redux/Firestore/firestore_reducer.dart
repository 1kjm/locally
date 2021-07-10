import 'package:locally/redux/Firestore/firestore_actions.dart';
import 'package:locally/redux/appstate.dart';

AppState dataFromFirestore(AppState newState, action) {
  if (action is SeperateActionForData) {
    newState.filterState.contacts = action.data;
    newState.filterState.initialState = action.data;
  }
  return newState;
}
