import 'package:locally/features/AutoCompleteTextField/domain/bloc/model.dart';
import 'package:locally/domain/redux/store.dart';

class ActfInitialStore {
//* [initialRun] is to initialize the streambuilder with values from firestore;
  static BlocModel initialrun() {
    return BlocModel(
        buildTrigger: false,
        locationdata: store.state.locationIndexList.toList());
  }
}
