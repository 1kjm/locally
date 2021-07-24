import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locally/features/AutoCompleteTextField/actf_repository.dart';

class ActfServices {
  ///*[dataFromFirestore]Fetching locationdata from firestore and converting it into a List of locations;
  ///This is used by the futurebuilder;
  Future dataFromFirestore() async {
    print('firestore actf called');
    return await FirebaseFirestore.instance
        .collection('locations')
        .doc('locationIndex')
        .get()
        .then((docSnapshot) {
      if (docSnapshot.data() != null) {
        locationsActf.addAll(docSnapshot.data()!['locations']);
        return docSnapshot.data()!['locations'];
      }
    });
  }
}
