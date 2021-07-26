import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locally/features/actf_redux_actions.dart';
import 'package:locally/redux/appstate.dart';
import 'package:redux/redux.dart';

class ActfMiddleWare {
  locationIndexMiddleware() {
    return (Store<AppState> store, action, NextDispatcher next) async {
      if (action is GetLocationIndex) {
        Future<DocumentSnapshot<Map<String, dynamic>>> locationIndex =
            FirebaseFirestore.instance
                .collection('locations')
                .doc('locationIndex')
                .get();

        await locationIndex.then((docSnapshot) {
          if (docSnapshot.data() != null) {
            List temp = docSnapshot.data()!['locations'];
            store.dispatch(SaveLocationIndex(payload: temp, hasDataFlag: true));
          }
        });
      }
      next(action);
    };
  }
}
