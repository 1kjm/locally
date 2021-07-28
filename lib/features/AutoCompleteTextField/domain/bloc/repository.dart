import 'package:locally/features/AutoCompleteTextField/domain/bloc/model.dart';
import 'package:locally/redux_store.dart';

class ActfInitialStore {
//* [initialRun] is to initialize the streambuilder with values from firestore;
  static BlocModel initialrun() {
    return BlocModel(
        buildTrigger: false, locationdata: store.state.locationIndex.toList());
  }
}
