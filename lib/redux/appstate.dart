import 'package:flutter/material.dart';
import 'package:locally/model/contact_model.dart';

import 'package:locally/redux/Routes/navigation_appstate.dart';
import 'package:locally/redux/features/DropdownFilter/ddf_appstate.dart';

import 'package:locally/theme.dart';

class AppState {
  //DDF(DropDownFilter);
  DDFAppState filterState = DDFAppState.initialState();

  ///NavigationAppstate is declared in 'Redux/Routes/navigation_appState';
  NavigationAppState navigationState = NavigationAppState.initialState();

  ///[tempcontacts] is for creation of contact_screen.dart
  List<ContactModel> tempContacts = [];

  ///AppTheme
  late ThemeData customtheme;

  ///LocationIndex
  late List locationIndex;

  AppState({
    required this.tempContacts,
    required this.customtheme,
    required this.locationIndex,
  });
  factory AppState.initialState() => AppState(
        tempContacts: [],
        customtheme: AppTheme.theme,
        locationIndex: [],
      );

  AppState.fromAppState(AppState another) {
    filterState.dropDownFilterParameter =
        another.filterState.dropDownFilterParameter;
    filterState.contacts = another.filterState.contacts;
    navigationState = another.navigationState;
    tempContacts = another.tempContacts;
    customtheme = another.customtheme;
    filterState.initialState = another.filterState.initialState;

    locationIndex = another.locationIndex;
  }
}
