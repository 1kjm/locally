import 'package:locally/redux/appstate.dart';
import 'package:locally/redux/features/DropdownFilter/ddf_actions.dart';

AppState dropDownfilterReducer(AppState newState, action) {
  if (action is FilterAll) {
    newState.filterState.contacts = action.initialState.toList();
    newState.filterState.dropDownFilterParameter = action.payload;
  } else if (action is FilterStore) {
    newState.filterState.contacts = action.initialState.toList();

    newState.filterState.contacts = newState.filterState.contacts
      ..retainWhere((element) => element.isStore);
    newState.filterState.dropDownFilterParameter = action.payload;
  } else if (action is FilterPeople) {
    newState.filterState.contacts = action.initialState.toList();
    newState.filterState.contacts = newState.filterState.contacts
      ..retainWhere((element) => element.isPeople);
    newState.filterState.dropDownFilterParameter = action.payload;
  }

  return newState;
}
