import 'package:locally/model/contact_model.dart';

class DDFAppState {
  List<ContactModel> contacts = [];
  //for storing initial State;
  List<ContactModel> immutableContactStore = [];
  String dropDownFilterParameter;

  DDFAppState(
      {required this.contacts,
      required this.dropDownFilterParameter,
      required this.immutableContactStore});

  factory DDFAppState.initialState() => DDFAppState(
        dropDownFilterParameter: 'All',
        contacts: [],
        immutableContactStore: [],
      );
}
