import 'package:flutter/material.dart';
import 'package:locally/model/contact_model.dart';

import 'package:locally/redux/Routes/navigation_appstate.dart';
import 'package:locally/redux/features/DropdownFilter/ddf_appstate.dart';
import 'package:locally/redux/initialRunChecker/initial_run_check_state.dart';

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
  InitialRunCheckState initialRunCheckState = InitialRunCheckState.initial();

  AppState({
    required this.tempContacts,
    required this.customtheme,
  });
  factory AppState.initialState() => AppState(
        tempContacts: [],
        customtheme: AppTheme.theme,
      );

  AppState.fromAppState(AppState another) {
    filterState.dropDownFilterParameter =
        another.filterState.dropDownFilterParameter;
    filterState.contacts = another.filterState.contacts;
    navigationState = another.navigationState;
    tempContacts = another.tempContacts;
    customtheme = another.customtheme;
    filterState.initialState = another.filterState.initialState;
    initialRunCheckState.isInitialRun =
        another.initialRunCheckState.isInitialRun;
  }
}
