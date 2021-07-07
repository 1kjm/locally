import 'package:locally/redux/appstate.dart';
import 'package:locally/redux/features/DropdownFilter/ddf_actions.dart';

AppState dropDownfilterReducer(AppState newState, action) {
  if (action is FilterAll) {
    newState.filterState.locations = action.initialState.toList();
    newState.filterState.dropDownFilterParameter = action.payload;
  } else if (action is FilterStore) {
    newState.filterState.locations = action.initialState.toList();

    newState.filterState.locations = newState.filterState.locations
      ..retainWhere((element) => element.store);
    newState.filterState.dropDownFilterParameter = action.payload;
  } else if (action is FilterPeople) {
    newState.filterState.locations = action.initialState.toList();
    newState.filterState.locations = newState.filterState.locations
      ..retainWhere((element) => element.people);
    newState.filterState.dropDownFilterParameter = action.payload;
  }

  return newState;
}
