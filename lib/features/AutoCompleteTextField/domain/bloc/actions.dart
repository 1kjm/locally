//this is to show the List of suggestions.
import 'package:locally/features/AutoCompleteTextField/domain/bloc/bloc.dart';

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
