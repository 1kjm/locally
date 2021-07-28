import 'package:locally/features/AutoCompleteTextField/data/redux/actions.dart';
import 'package:locally/redux/appstate.dart';

AppState locationDataFromFirestore(AppState newState, action) {
  if (action is SaveLocationIndex) {
    newState.locationIndex = action.payload;
  }
  return newState;
}
