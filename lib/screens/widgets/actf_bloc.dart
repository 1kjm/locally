import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlocModel {
  List locationdata;
  bool buildTrigger;
  BlocModel({required this.buildTrigger, required this.locationdata});
}

//*set of locationsACTF stores the locationIndexData from firestore.
//Set also prevents duplicates during multiple runs of [dataFromFirestore];
Set locationsActf = {};

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

class ActfInitialStore {
//* [initialRun] is to initialize the streambuilder with values from firestore;
  BlocModel initialrun() {
    return BlocModel(buildTrigger: false, locationdata: locationsActf.toList());
  }
}

class ActfBloc {
//*eventcontroller listens to changes in state and updates blocstatecontroller;
  final _blocStateController = StreamController<BlocModel>();
  final _eventController = StreamController<String>();

//*State
  StreamSink<BlocModel> get listInput => _blocStateController.sink;
  Stream<BlocModel> get outputList => _blocStateController.stream;

//*Event
  StreamSink<String> get eventInput => _eventController.sink;
  ActfBloc() {
    _eventController.stream.listen(listConverter);
  }

  void listConverter(String event) {
    BlocModel dummy = ActfInitialStore().initialrun();
    print(locationsActf);
    //locationdata logic
    dummy.locationdata
        .retainWhere((element) => element.toString().contains(event));
    //buildTrigger logic
    event.length > 1 ? dummy.buildTrigger = true : dummy.buildTrigger = false;
    listInput.add(dummy);
  }

//*To dispose the StreamControllers as well as to clear Global LocationActf variable;
//This is called from [dispose] in widget tree;
  void dispose() {
    _blocStateController.close();
    _eventController.close();
    locationsActf.clear();
  }
}
