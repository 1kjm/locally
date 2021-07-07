import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/DummyData/dummy.dart';
import 'package:locally/model/contact_model.dart';

import 'package:locally/model/destination_model.dart';
import 'package:locally/redux/Routes/navigation_action.dart';

import 'package:locally/redux/appstate.dart';
import 'package:locally/redux/features/DropdownFilter/ddf_actions.dart';

import 'package:locally/redux/features/searchbar/searchbar_action.dart';

class DirectoryScreen extends StatefulWidget {
  DirectoryScreen({Key? key}) : super(key: key);

  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  //*TextEditing Controller for SearchBar
  TextEditingController textEditingController = TextEditingController();
  //*AppState for comparing previous state with present state for [``searchBarLogic]
  late AppState tempStateForSearchBar;
  //*[tempDropDownFilterParameter] is for storing and comparing dropdownChanges. This variable is utilized in [``searchBarlogic]
  late String tempDropDownFilterParameter; //searchbar logic

  //*Storing Contacts Details
  final List<ContactModel> initialState = DummyData().contacts;
  //*Filter Parameters used in DropDownMenu
  final List<String> filterParameters = ['All', 'People', 'Store'];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Directory_Screen State Updated');
    final store = StoreProvider.of<AppState>(context);
    tempStateForSearchBar = store.state;
    tempDropDownFilterParameter =
        store.state.filterState.dropDownFilterParameter;

    return Container(
      margin: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              Container(
                child: StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (context, vm) => DropdownButton<String>(
                      style: TextStyle(color: Colors.red),
                      iconEnabledColor: Colors.blue,
                      dropdownColor: Colors.white,
                      value: store.state.filterState
                          .dropDownFilterParameter, //DropdownMenu Logic
                      items: filterParameters
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        _dropDownMenuLogic(value: value, context: context);
                      }),
                ),
              ),
              Expanded(flex: 1, child: searchBar(context)),
            ]),
          ),
          SizedBox(
            height: 3,
          ),
          Expanded(
            flex: 1,
            child: Container(
                child: StoreConnector<AppState, List>(
                    converter: (store) =>
                        store.state.filterState.locations.toList(),
                    builder: (context, vm) {
                      _searchBarLogic(context);
                      return ListView.builder(
                        itemBuilder: (context, index) => customListTile(
                          id: vm[index].id,
                          isPeople: vm[index].people,
                          name: vm[index].name,
                          designation: vm[index].designation,
                        ),
                        itemCount: store.state.filterState.locations.length,
                      );
                    })),
          )
        ],
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.all(3),
          child: TextField(
            onChanged: (value) {
              textEditingController.addListener(() {
                print(textEditingController.text);
                StoreProvider.of<AppState>(context).dispatch(SearchInputAction(
                  stateForSearchBarLogic: tempStateForSearchBar,
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
              color: Colors.blueAccent),
        ),
        title: Text(
          name.toString(),
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        subtitle:
            Text(designation.toString(), style: TextStyle(color: Colors.green)),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0));
  }

  // TODO: try to optimize for better UI so that user does not see the clearing action;
  void _onListTileTap(int id) {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(MakeListTileInContactScreen(id: id));
    store.dispatch(NavigateToNext(destination: Destination.CONTACTSPAGE));
    //*to clear textediting controller after navigating to next page
    //*if this is not present data will persist on navigating back and cause duplication of text;
    textEditingController.clear();
  }

  //TODO: Try to seperate DROPDOWNMENU logic from UI
//dispatch action after comparing value from dropdownMenu
  void _dropDownMenuLogic(
      {required String? value, required BuildContext context}) {
    final store = StoreProvider.of<AppState>(context);
    if (value == 'All') {
      store.dispatch(
          FilterAll(payload: value.toString(), initialState: initialState));
    } else if (value == 'Store') {
      store.dispatch(
          FilterStore(payload: value.toString(), initialState: initialState));
    } else {
      store.dispatch(
          FilterPeople(payload: value.toString(), initialState: initialState));
    }
  }

//TODO: Try to seperate SEARCHBAR logic from UI
  //*SEARCHBAR LOGIC
  ///tempstateforsearchbar stores the initial state of each dropDownMenu, and performs search function on that state itself.
  ///anychange in state is determined by comparing tempDropdownIndex with present dropdownIndex
  void _searchBarLogic(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    int comparePresentDropDownWithPrevious = tempDropDownFilterParameter
        .compareTo(store.state.filterState.dropDownFilterParameter);
    print('SearchBar logic ' + comparePresentDropDownWithPrevious.toString());
    if (comparePresentDropDownWithPrevious != 0) {
      tempStateForSearchBar =
          store.state; //Replaces previousState with NewState
      tempDropDownFilterParameter =
          store.state.filterState.dropDownFilterParameter;
    }
  }
}
