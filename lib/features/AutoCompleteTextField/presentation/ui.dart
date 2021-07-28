import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/features/AutoCompleteTextField/domain/bloc/bloc.dart';

import 'package:locally/features/AutoCompleteTextField/presentation/body.dart';

import 'package:locally/redux/appstate.dart';

class AutoCompleteTextField extends StatefulWidget {
  const AutoCompleteTextField({Key? key}) : super(key: key);

  @override
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final bloc = ActfBloc();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List>(
        converter: (store) => store.state.locationIndex,
        builder: (context, vm) => vm.length > 0
            ? ActfBody()
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
