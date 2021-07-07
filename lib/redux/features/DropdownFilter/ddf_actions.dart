import 'package:locally/model/contact_model.dart';

class FilterAll {
  final List<ContactModel> initialState;
  final String payload;
  FilterAll({required this.payload, required this.initialState});
}

class FilterStore {
  final List<ContactModel> initialState;
  final String payload;
  FilterStore({required this.payload, required this.initialState});
}

class FilterPeople {
  final List<ContactModel> initialState;
  final String payload;
  FilterPeople({required this.payload, required this.initialState});
}
