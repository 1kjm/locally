import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/domain/redux/appstate.dart';
import 'package:locally/features/Filter&SearchBar/DropDownFilter/domain/ddf_actions.dart';

class DropDownFilterWidget extends StatefulWidget {
  const DropDownFilterWidget({Key? key}) : super(key: key);

  @override
  _DropDownFilterWidgetState createState() => _DropDownFilterWidgetState();
}

class _DropDownFilterWidgetState extends State<DropDownFilterWidget> {
  final List<String> filterParameters = ['All', 'People', 'Store'];
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, vm) {
        return DropdownButton<String>(
            style: TextStyle(color: Colors.indigo),
            iconEnabledColor: Colors.indigo[700],
            dropdownColor: Colors.white,
            value: vm.filterState.dropDownFilterParameter, //DropdownMenu Logic
            items: filterParameters
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (value) {
              _changeFilterParameter(value: value);
            });
      },
    );
  }

  void _changeFilterParameter({
    required String? value,
  }) {
    final store = StoreProvider.of<AppState>(context);

    switch (value) {
      case 'All':
        store.dispatch(FilterAll(payload: value.toString()));
        break;
      case 'Store':
        store.dispatch(FilterStore(payload: value.toString()));
        break;
      case 'People':
        store.dispatch(FilterPeople(payload: value.toString()));
        break;
      default:
        store.dispatch(FilterAll(
          payload: value.toString(),
        ));
    }
  }
}
