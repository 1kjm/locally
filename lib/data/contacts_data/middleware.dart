import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locally/model/contact_model.dart';

import 'package:locally/data/contacts_data/actions.dart';
import 'package:locally/domain/redux/appstate.dart';
import 'package:redux/redux.dart';

class FirestoreMiddleWare {
  firebaseFirestoreMiddleware() {
    return (Store<AppState> store, action, NextDispatcher next) async {
      if (action is GetDataFromFirestore) {
        await FirebaseFirestore.instance
            .collection('locations')
            .doc(action.payload)
            .collection('contacts')
            .doc('data')
            .get()
            .then((docSnapshot) {
          if (docSnapshot.data() != null) {
            print(docSnapshot.data().toString());
            store.dispatch(
                SeperateActionForData(dataConverter(docSnapshot.data())));
          } else {
            print('no data in firestore');
          }
        });
      }
      next(action);
    };
  }

  List<ContactModel> dataConverter(dynamic mydata) {
    List<ContactModel> temporary = [];
    mydata!.forEach((String key, dynamic value) {
      value.forEach((element) {
        temporary.add(ContactModel(
            designation: element['designation'],
            name: element['name'],
            phoneNumber: element['phoneNumber'],
            isStore: element['isStore'],
            isPeople: element['isPeople'],
            id: element['id']));
      });
    });
    return temporary;
  }
}
