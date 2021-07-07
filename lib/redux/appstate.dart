import 'package:flutter/material.dart';
import 'package:locally/DummyData/dummy.dart';
import 'package:locally/model/contact_model.dart';
import 'package:locally/redux/Routes/navigation_appstate.dart';
import 'package:locally/redux/features/DropdownFilter/ddf_appstate.dart';
import 'package:locally/theme.dart';

class AppState {
  //DDF(DropDownFilter);
  DDFAppState filterState = DDFAppState.initialState();

  ///
  ///
  NavigationAppState navigationState = NavigationAppState.initialState();

  ///NavigationAppstate is declared in 'Redux/Routes/navigation_appState';
  ///
  List<ContactModel> tempContacts = [];

  ///[tempcontacts] is for creation of contact_screen.dart
  ///
  late ThemeData customtheme;

  ///AppTheme
  ///
  AppState({required this.tempContacts, required this.customtheme});
  factory AppState.initialState() =>
      AppState(tempContacts: DummyData().contacts, customtheme: AppTheme.theme);

  AppState.fromAppState(AppState another) {
    filterState.dropDownFilterParameter =
        another.filterState.dropDownFilterParameter;
    filterState.locations = another.filterState.locations;
    navigationState = another.navigationState;
    tempContacts = another.tempContacts;
    //TODO: customtheme = another.customtheme;
    ///*this can be used to change apptheme in the nextupdate
  }
}
