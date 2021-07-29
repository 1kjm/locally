import 'package:locally/domain/redux/appstate.dart';

import 'package:locally/features/Filter&SearchBar/Searchbar/domain/action.dart';

AppState searchInputReducer(AppState newState, action) {
  if (action is SearchInputAction) {
    newState.searchBarState.searchBarState =
        newState.filterState.contacts.toList();
    if (action.payload.isNotEmpty) {
      newState.searchBarState.searchBarState = newState.filterState.contacts
          .where((element) =>
              element.name.toLowerCase().contains(action.payload.toLowerCase()))
          .toList();
    } else {
      newState.searchBarState.searchBarState = newState.filterState.contacts;
    }
  }
  return newState;
}
