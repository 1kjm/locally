import 'dart:async';

import 'package:locally/features/AutoCompleteTextField/actf_bloc_actions.dart';

import 'package:locally/redux_store.dart';

//*recieveInputFlag is used to control the data passed into the Stream;
bool recieveInputFlag = true;

class BlocModel {
  List locationdata;
  bool buildTrigger;
  BlocModel({required this.buildTrigger, required this.locationdata});
}

class ActfInitialStore {
//* [initialRun] is to initialize the streambuilder with values from firestore;
  static BlocModel initialrun() {
    return BlocModel(
        buildTrigger: false, locationdata: store.state.locationIndex.toList());
  }
}

class ActfBloc {
//*eventcontroller listens to changes in state and updates blocstatecontroller;
  final _blocStateController = StreamController<BlocModel>();
  final _eventController = StreamController();

//*State
  StreamSink<BlocModel> get listInput => _blocStateController.sink;
  Stream<BlocModel> get outputList => _blocStateController.stream;

//*Event
  StreamSink get eventInput => _eventController.sink;
  ActfBloc() {
    _eventController.stream.listen(listConverter);
  }

  void listConverter(event) {
    print('recieveInputFlag= ' + recieveInputFlag.toString());
    BlocModel suggestions = ActfInitialStore.initialrun();

    if (event is ShowList) {
      if (event.textInput.isEmpty) {
        ResetBloc.reset();
        recieveInputFlag = true;
      } else if (recieveInputFlag == true) {
        //locationdata logic
        suggestions.locationdata.retainWhere(
            (element) => element.toString().contains(event.textInput));
        //buildTrigger logic

        event.textInput.length > 1
            ? suggestions.buildTrigger = true
            : suggestions.buildTrigger = false;

        listInput.add(suggestions);
      }
    } else if (event is HideList) {
      recieveInputFlag = false;
      suggestions.buildTrigger = false;
      listInput.add(suggestions);
    }
  }

//*To dispose the StreamControllers as well as to clear Global LocationActf variable;
//This is called from [dispose] in widget tree;
  void dispose() {
    _blocStateController.close();
    _eventController.close();
  }
}
