import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/features/AutoCompleteTextField/domain/bloc/actions.dart';
import 'package:locally/features/AutoCompleteTextField/domain/bloc/bloc.dart';
import 'package:locally/features/AutoCompleteTextField/domain/bloc/model.dart';
import 'package:locally/features/AutoCompleteTextField/domain/bloc/repository.dart';

import 'package:locally/model/destination_model.dart';
import 'package:locally/data/contacts_data/actions.dart';
import 'package:locally/features/Navigation/redux/action.dart';
import 'package:locally/domain/redux/appstate.dart';

class ActfBody extends StatefulWidget {
  const ActfBody({Key? key}) : super(key: key);

  @override
  _ActfBodyState createState() => _ActfBodyState();
}

class _ActfBodyState extends State<ActfBody> {
  final TextEditingController textEditingController = TextEditingController();
  FocusNode _myFocusNode = FocusNode();
  @override
  void dispose() {
    textEditingController.dispose();
    _myFocusNode.dispose();
    bloc.dispose();
    super.dispose();
  }

  final bloc = ActfBloc();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: bloc.outputList,
        initialData: ActfInitialStore.initialrun(),
        builder: (context, AsyncSnapshot<BlocModel> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return stackUi(size, streamSnapshot);
          } else
            return Center(child: Text('Please Wait'));
        });
  }

  Stack stackUi(Size size, AsyncSnapshot<dynamic> streamSnapshot) {
    return Stack(
      children: <Widget>[
        new Column(
          children: <Widget>[
            Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: size.height * 0.07),
                  searchBarCard(),
                  SizedBox(height: size.height * 0.03),
                  !streamSnapshot.data!.buildTrigger
                      ? Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(20),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.indigo[600]),
                                ),
                                onPressed: _onElevatedButtonPressed,
                                child: const Text(
                                  '    Search    ',
                                  style: const TextStyle(fontSize: 18.0),
                                )),
                          ),
                        )
                      : Container(),
                  SizedBox(height: size.height * 0.04),
                ],
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.topCenter,
          padding:
              EdgeInsets.only(top: size.height * .21, right: 10.0, left: 10.0),
          child: streamSnapshot.data!.buildTrigger
              ? listTileWidget(streamSnapshot.data!.locationdata)
              : null,
        )
      ],
    );
  }

  Card searchBarCard() {
    return Card(
      color: Colors.indigo[50],
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.indigo[700],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: SizedBox(
                  child: Icon(
                Icons.search_rounded,
                color: Colors.white,
              )),
            ),
          ),
          Expanded(
            flex: 8,
            child: ClipRRect(
              child: TextFormField(
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  focusNode: _myFocusNode,
                  controller: textEditingController,
                  onChanged: _textFieldListner,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '  Search Location',
                  )),
            ),
          )
        ],
      ),
    );
  }

  void _onElevatedButtonPressed() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(GetDataFromFirestore(
        payload: textEditingController.value.text.toLowerCase()));
    store.dispatch(NavigateToNext(destination: Destination.HOMEPAGE));
    textEditingController.clear();
    _myFocusNode.unfocus();
  }

  void _textFieldListner(String value) {
    textEditingController.addListener(() {
      bloc.eventInput.add(ShowList(textEditingController.value.text));
    });
  }

  Widget listTileWidget(List locationIndex) {
    return ListView.builder(
        itemCount: locationIndex.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.place_rounded),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: Colors.blue[50],
            onTap: () => onListTileTapped(locationIndex[index]),
            title: Text(
              locationIndex[index].toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        });
  }

  void onListTileTapped(String location) {
    textEditingController.clear();
    textEditingController.text = location;
    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length));
    bloc.eventInput.add(HideList());
  }
}
