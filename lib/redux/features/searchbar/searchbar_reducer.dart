import 'package:locally/redux/appstate.dart';

import 'package:locally/redux/features/searchbar/searchbar_action.dart';

AppState searchInputReducer(AppState newState, action) {
  if (action is SearchInputAction) {
    if (action.payload.isNotEmpty) {
      final tempStorage = action.stateForSearchBarLogic.filterState;
      newState.filterState.locations = tempStorage.locations
          .where((element) =>
              element.name.toLowerCase().contains(action.payload.toLowerCase()))
          .toList();
    } else {
      newState.filterState.locations =
          action.stateForSearchBarLogic.filterState.locations;
    }
  }
  return newState;
}
