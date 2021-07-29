import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:locally/features/AutoCompleteTextField/presentation/body.dart';

import 'package:locally/domain/redux/appstate.dart';

class AutoCompleteTextField extends StatefulWidget {
  const AutoCompleteTextField({Key? key}) : super(key: key);

  @override
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List>(
        converter: (store) => store.state.locationIndexList,
        builder: (context, vm) => vm.length > 0
            ? ActfBody()
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
