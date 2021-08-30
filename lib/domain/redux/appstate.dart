import 'package:flutter/material.dart';
import 'package:locally/model/contact_model.dart';

import 'package:locally/features/Navigation/redux/state.dart';
import 'package:locally/features/Filter&SearchBar/DropDownFilter/domain/ddf_appstate.dart';
import 'package:locally/features/Filter&SearchBar/Searchbar/domain/state.dart';

import 'package:locally/theme.dart';

class AppState {
  //DDF(DropDownFilter);
  DDFAppState filterState = DDFAppState.initialState();
  SearchBarAppState searchBarState = SearchBarAppState.initialState();

  ///NavigationAppstate is declared in 'Redux/Routes/navigation_appState';
  NavigationAppState navigationState = NavigationAppState.initialState();

  ///[tempcontacts] is for creation of contact_screen.dart
  List<ContactModel> tempContacts = [];

  ///AppTheme
  late ThemeData customtheme;
  late String myLocation;

  ///LocationIndex
  late List locationIndexList;

  AppState(
      {required this.tempContacts,
      required this.customtheme,
      required this.locationIndexList,
      required this.myLocation});
  factory AppState.initialState() => AppState(
      tempContacts: [],
      customtheme: AppTheme.theme,
      locationIndexList: [],
      myLocation: '');

  AppState.fromAppState(AppState another) {
    filterState.dropDownFilterParameter =
        another.filterState.dropDownFilterParameter;
    filterState.contacts = another.filterState.contacts;
    navigationState = another.navigationState;
    tempContacts = another.tempContacts;
    customtheme = another.customtheme;
    filterState.immutableContactStore =
        another.filterState.immutableContactStore;
    locationIndexList = another.locationIndexList;
    searchBarState.searchBarState = another.searchBarState.searchBarState;
    myLocation = another.myLocation;
  }
}
