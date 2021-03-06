import 'package:flutter/material.dart';
import 'package:locally/model/destination_model.dart';
import 'package:locally/presentation/screens/contact_screen.dart';
import 'package:locally/presentation/screens/home_screen.dart';
import 'package:locally/presentation/screens/intro_screen.dart';

class DestinationToWidgetConverter {
  Widget convert(Destination input) {
    switch (input) {
      case Destination.INTROSCREEN:
        return IntroScreen();
      case Destination.HOMEPAGE:
        return HomeScreen();
      case Destination.CONTACTSPAGE:
        return ContactScreen();

      default:
        return IntroScreen();
    }
  }
}
