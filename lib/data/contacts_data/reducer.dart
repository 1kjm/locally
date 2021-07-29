import 'package:locally/data/contacts_data/actions.dart';
import 'package:locally/domain/redux/appstate.dart';

AppState dataFromFirestore(AppState newState, action) {
  if (action is SeperateActionForData) {
    newState.filterState.contacts = action.data;
    newState.filterState.immutableContactStore = action.data;
  }
  return newState;
}
