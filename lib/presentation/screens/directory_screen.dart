import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/features/Filter&SearchBar/DropDownFilter/presentation/ui.dart';
import 'package:locally/features/Filter&SearchBar/Searchbar/presentation/ui.dart';

import 'package:locally/model/destination_model.dart';
import 'package:locally/features/Navigation/redux/action.dart';

import 'package:locally/domain/redux/appstate.dart';

import 'package:locally/features/Filter&SearchBar/Searchbar/domain/action.dart';

class DirectoryScreen extends StatefulWidget {
  DirectoryScreen({Key? key}) : super(key: key);

  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  @override
  Widget build(BuildContext context) {
    print('Directory_Screen State Updated');

    return Container(
      margin: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              DropDownFilterWidget(),
              Expanded(flex: 1, child: DirectorySearchBar()),
            ]),
          ),
          SizedBox(
            height: 3,
          ),
          Expanded(flex: 1, child: directoryBuilder()),
        ],
      ),
    );
  }

  StoreConnector<AppState, List<dynamic>> directoryBuilder() {
    return StoreConnector<AppState, List>(
        distinct: true,
        onInit: (e) => e.dispatch(SearchInputAction(payload: '')),
        converter: (store) => store.state.searchBarState.searchBarState,
        builder: (context, vm) {
          return vm.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (context, index) => customListTile(
                    id: vm[index].id,
                    isPeople: vm[index].isPeople,
                    name: vm[index].name,
                    designation: vm[index].designation,
                  ),
                  itemCount: vm.length,
                );
        });
  }

  ListTile customListTile(
      {required String name,
      required String designation,
      required bool isPeople,
      required int id}) {
    return ListTile(
        onTap: () => _onListTileTap(id),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(isPeople ? Icons.people : Icons.store,
              color: Colors.indigo[800]),
        ),
        title: Text(
          name.toString(),
          style:
              TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(designation.toString(),
            style: TextStyle(color: Colors.green[600])),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0));
  }

  void _onListTileTap(int id) {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(MakeListTileInContactScreen(id: id));
    store.dispatch(NavigateToNext(destination: Destination.CONTACTSPAGE));
  }
}
