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
  return newState;
}

AppState _idForListTileInContactPage(AppState newState, action) {
  if (action is MakeListTileInContactScreen) {
    newState.tempContacts.addAll(newState.filterState.locations);
    newState.tempContacts.retainWhere((element) => element.id == action.id);
  }
  return newState;
}
