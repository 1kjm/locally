import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/features/AutoCompleteTextField/actf_bloc_actions.dart';
import 'package:locally/features/AutoCompleteTextField/actf_logic.dart';
import 'package:locally/model/destination_model.dart';

import 'package:locally/redux/Routes/navigation_action.dart';

import 'package:locally/redux/appstate.dart';

class AutoCompleteTextField extends StatefulWidget {
  const AutoCompleteTextField({Key? key}) : super(key: key);

  @override
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  final TextEditingController textEditingController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    myFocusNode.dispose();
    bloc.dispose();
    super.dispose();
  }

  final bloc = ActfBloc();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final store = StoreProvider.of<AppState>(context);
    return FutureBuilder(
        future: store.state.hasLocationIndexData,
        builder: (context, futureSnapshot) {
          if (futureSnapshot.data == true) {
            return StreamBuilder(
                stream: bloc.outputList,
                initialData: ActfInitialStore.initialrun(),
                builder: (context, AsyncSnapshot<BlocModel> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return Stack(
                      children: <Widget>[
                        new Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(height: size.height * 0.07),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: RichText(
                                        text: TextSpan(
                                            text: 'Please Enter Your Location',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black))),
                                  ),
                                  Card(
                                    color: Colors.deepPurpleAccent[400],
                                    elevation: 10.0,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.all(10),
                                    child: TextFormField(
                                      controller: textEditingController,
                                      focusNode: myFocusNode,
                                      onChanged: (value) {
                                        textEditingController.addListener(() {
                                          bloc.eventInput.add(ShowList(
                                              textEditingController
                                                  .value.text));
                                        });
                                      },
                                      decoration: InputDecoration(
                                        fillColor: Colors.lime[200],
                                        border: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        filled: true,
                                        icon: (const Icon(
                                          Icons.search,
                                          color: Colors.red,
                                        )),
                                        hintText: 'Enter Your Location',
                                        labelText: 'Locations',
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.05),
                                  !streamSnapshot.data!.buildTrigger
                                      ? Center(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                store.dispatch(NavigateToNext(
                                                    destination:
                                                        Destination.HOMEPAGE));
                                                textEditingController.clear();
                                                myFocusNode.unfocus();
                                              },
                                              child: const Text(
                                                '    Search    ',
                                                style: const TextStyle(
                                                    fontSize: 18.0),
                                              )),
                                        )
                                      : Container(),
                                  SizedBox(height: size.height * 0.04),
                                ],
                              ),
                            ),
                          ],
                        ),
                        new Container(
                          alignment: Alignment.topCenter,
                          padding: new EdgeInsets.only(
                              top: size.height * .21, right: 10.0, left: 10.0),
                          child: streamSnapshot.data!.buildTrigger
                              ? listTileWidget(
                                  streamSnapshot.data!.locationdata)
                              : null,
                        )
                      ],
                    );
                  } else
                    return Center(child: Text('Please Wait'));
                });
          }
          return Center(child: CircularProgressIndicator());
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
            tileColor: index % 2 == 0 ? Colors.amber[100] : Colors.teal[100],
            onTap: () => onListTileTapped(locationIndex[index]),
            title: Text(locationIndex[index].toString()),
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
