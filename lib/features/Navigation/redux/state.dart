import 'dart:collection';

import 'package:locally/model/destination_model.dart';

class NavigationAppState {
  late Queue<Destination> activePages;
  NavigationAppState({required this.activePages});
  factory NavigationAppState.initialState() => NavigationAppState(
      activePages: Queue()
        ..add(
          Destination.HOMEPAGE,
        ));
}
