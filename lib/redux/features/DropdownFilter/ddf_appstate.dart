import 'package:locally/model/contact_model.dart';

class DDFAppState {
  List<ContactModel> contacts = [];
  List<ContactModel> initialState = [];

  late String dropDownFilterParameter;
  DDFAppState(
      {required this.contacts,
      required this.dropDownFilterParameter,
      required this.initialState});
  factory DDFAppState.initialState() => DDFAppState(
        dropDownFilterParameter: 'All',
        contacts: [],
        initialState: [],
      );
}
