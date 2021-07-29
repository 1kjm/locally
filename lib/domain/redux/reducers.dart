import 'package:locally/features/AutoCompleteTextField/data/redux/reducer.dart';
import 'package:locally/data/contacts_data/reducer.dart';
import 'package:locally/features/Navigation/redux/action.dart';
import 'package:locally/features/Navigation/redux/reducer.dart';
import 'package:locally/domain/redux/appstate.dart';
import 'package:locally/features/Filter&SearchBar/DropDownFilter/domain/ddf_reducer.dart';

import 'package:locally/features/Filter&SearchBar/Searchbar/domain/reducer.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);
  dropDownfilterReducer(newState, action);
  searchInputReducer(newState, action);
  navigatorReducer(newState, action); //for navigation between pages
  _idForListTileInContactPage(newState, action);
  dataFromFirestore(newState, action);
  locationDataFromFirestore(newState, action);

  return newState;
}

AppState _idForListTileInContactPage(AppState newState, action) {
  if (action is MakeListTileInContactScreen) {
    newState.tempContacts.addAll(newState.filterState.contacts);
    newState.tempContacts.retainWhere((element) => element.id == action.id);
  }
  return newState;
}
