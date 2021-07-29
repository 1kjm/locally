import 'package:locally/model/contact_model.dart';

class SearchBarAppState {
  List<ContactModel> searchBarState = [];
  SearchBarAppState({required this.searchBarState});
  factory SearchBarAppState.initialState() =>
      SearchBarAppState(searchBarState: []);
}
