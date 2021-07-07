import 'package:locally/redux/appstate.dart';

class SearchInputAction {
  final String payload;
  final AppState stateForSearchBarLogic;

  SearchInputAction(
      {required this.payload, required this.stateForSearchBarLogic});
}
