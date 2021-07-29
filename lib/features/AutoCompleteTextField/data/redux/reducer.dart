import 'package:locally/features/AutoCompleteTextField/data/redux/actions.dart';
import 'package:locally/domain/redux/appstate.dart';

///Saves the 'LocationIndex' Coming as payload to Store;
AppState locationDataFromFirestore(AppState newState, action) {
  if (action is SaveLocationIndex) {
    newState.locationIndexList = action.payload;
  }
  return newState;
}
