import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/domain/redux/appstate.dart';
import 'package:locally/features/Filter&SearchBar/Searchbar/domain/action.dart';

class DirectorySearchBar extends StatefulWidget {
  const DirectorySearchBar({Key? key}) : super(key: key);

  @override
  _DirectorySearchBarState createState() => _DirectorySearchBarState();
}

class _DirectorySearchBarState extends State<DirectorySearchBar> {
  FocusNode _myfocusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    _myfocusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.all(3),
          child: TextField(
            focusNode: _myfocusNode,
            onChanged: (listenedvalue) {
              textEditingController.addListener(() {
                print(textEditingController.text);
                StoreProvider.of<AppState>(context).dispatch(SearchInputAction(
                  payload: textEditingController.text.toString(),
                ));
              });
            },
            controller: textEditingController,
            keyboardType: TextInputType.name,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'Search'),
          ),
        ));
  }
}
