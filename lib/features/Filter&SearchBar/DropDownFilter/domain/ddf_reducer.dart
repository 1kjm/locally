import 'package:locally/domain/redux/appstate.dart';
import 'package:locally/features/Filter&SearchBar/DropDownFilter/domain/ddf_actions.dart';

///when action is [FilterAll]/[FilterStore]/[FilterPeople] the contacts get initialized by immutableContactStore;
///immutableContactStore holds the initialdata from firestore;
///the [filterstate.contacts] is not directly used to update UI;
///filterstate.contacts is passed on to searchbarstate;
///searchbarstate is used to populate the [directorybuilder] widget in Directory Screen;

AppState dropDownfilterReducer(AppState newState, action) {
  if (action is FilterAll) {
    newState.filterState.contacts =
        newState.filterState.immutableContactStore.toList();
    newState.searchBarState.searchBarState = newState.filterState.contacts;
    newState.filterState.dropDownFilterParameter = action.payload;
  } else if (action is FilterStore) {
    newState.filterState.contacts =
        newState.filterState.immutableContactStore.toList();
    newState.filterState.contacts = newState.filterState.contacts
      ..retainWhere((element) => element.isStore);
    newState.searchBarState.searchBarState = newState.filterState.contacts;
    newState.filterState.dropDownFilterParameter = action.payload;
  } else if (action is FilterPeople) {
    newState.filterState.contacts =
        newState.filterState.immutableContactStore.toList();
    newState.filterState.contacts = newState.filterState.contacts
      ..retainWhere((element) => element.isPeople);
    newState.searchBarState.searchBarState = newState.filterState.contacts;
    newState.filterState.dropDownFilterParameter = action.payload;
  }

  return newState;
}
