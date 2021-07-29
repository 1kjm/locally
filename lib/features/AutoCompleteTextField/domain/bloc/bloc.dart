import 'dart:async';
import 'package:locally/features/AutoCompleteTextField/domain/bloc/actions.dart';
import 'package:locally/features/AutoCompleteTextField/domain/bloc/model.dart';
import 'package:locally/features/AutoCompleteTextField/domain/bloc/repository.dart';

///global Variable [recieveInputFlag] used to control the data passed into the Stream;
bool recieveInputFlag = true;

class ActfBloc {
  ///eventcontroller listens to changes in state and updates blocstatecontroller;
  final _blocStateController = StreamController<BlocModel>();
  final _eventController = StreamController();

  ///State
  StreamSink<BlocModel> get listInput => _blocStateController.sink;
  Stream<BlocModel> get outputList => _blocStateController.stream;

  ///Event
  StreamSink get eventInput => _eventController.sink;
  ActfBloc() {
    _eventController.stream.listen(listConverter);
  }

  void listConverter(event) {
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

  ///To dispose the StreamControllers;
  ///This is called from [dispose] in widget tree;
  void dispose() {
    _blocStateController.close();
    _eventController.close();
  }
}
