import 'package:locally/model/contact_model.dart';

///This action Takes a String, which points towards the document name in firestore;
class GetDataFromFirestore {
  String payload;
  GetDataFromFirestore({required this.payload});
}

class SeperateActionForData {
  final List<ContactModel> data;
  SeperateActionForData(this.data);
}
