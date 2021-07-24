import 'package:locally/features/AutoCompleteTextField/actf_repository.dart';

//this is to show the List of suggestions.
class ShowList {
  String textInput;
  ShowList(this.textInput);
}

//To HideList of suggestions;
class HideList {}

//To reset Suggestions;
class ResetBloc {
  static void reset() {
    recieveInputFlag = true;
  }
}
