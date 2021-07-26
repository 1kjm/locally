import 'package:locally/features/actf_reducer.dart';
import 'package:locally/redux/Firestore/firestore_reducer.dart';
import 'package:locally/redux/Routes/navigation_action.dart';
import 'package:locally/redux/Routes/navigation_reducer.dart';
import 'package:locally/redux/appstate.dart';
import 'package:locally/redux/features/DropdownFilter/ddf_reducer.dart';

import 'package:locally/redux/features/searchbar/searchbar_reducer.dart';

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
