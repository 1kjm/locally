import 'package:locally/features/AutoCompleteTextField/actf_redux_actions.dart';
import 'package:locally/redux/appstate.dart';

AppState locationDataFromFirestore(AppState newState, action) {
  if (action is SaveLocationIndex) {
    newState.locationIndex = action.payload;
  }
  return newState;
}
