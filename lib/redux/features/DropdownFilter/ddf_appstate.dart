import 'package:locally/DummyData/dummy.dart';
import 'package:locally/model/contact_model.dart';

class DDFAppState {
  List<ContactModel> locations = [];

  late String dropDownFilterParameter;
  DDFAppState({
    required this.locations,
    required this.dropDownFilterParameter,
  });
  factory DDFAppState.initialState() => DDFAppState(
        dropDownFilterParameter: 'All',
        locations: DummyData().contacts,
      );
}
