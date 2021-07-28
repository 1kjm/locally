import 'package:locally/model/contact_model.dart';

class GetDataFromFirestore {
  String payload;
  GetDataFromFirestore({required this.payload});
}

class SeperateActionForData {
  final List<ContactModel> data;
  SeperateActionForData(this.data);
}
