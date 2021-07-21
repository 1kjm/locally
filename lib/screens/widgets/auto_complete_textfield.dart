import 'package:flutter/material.dart';

import 'package:locally/screens/widgets/actf_bloc.dart';

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
    return FutureBuilder(
        future: ActfServices().dataFromFirestore(),
        builder: (context, futureSnapshot) {
          if (!futureSnapshot.hasData) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Center(
                child: Text('No Data'),
              );
          } else if (futureSnapshot.hasData) {
            return StreamBuilder(
                stream: bloc.outputList,
                initialData: ActfInitialStore().initialrun(),
                builder: (context, AsyncSnapshot<BlocModel> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return Stack(
                      children: <Widget>[
                        new Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const SizedBox(height: 80.0),
                                  new TextFormField(
                                    controller: textEditingController,
                                    focusNode: myFocusNode,
                                    onChanged: (value) {
                                      textEditingController.addListener(() {
                                        if (textEditingController
                                            .value.text.isNotEmpty) {
                                          bloc.eventInput.add(
                                              textEditingController.value.text);
                                        }
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      filled: true,
                                      icon: const Icon(Icons.search),
                                      hintText: 'Type two words with space',
                                      labelText: 'Search words *',
                                    ),
                                  ),
                                  const SizedBox(height: 40.0),
                                  new Center(
                                    child: new ElevatedButton(
                                        onPressed: () => print("Pressed"),
                                        child: const Text(
                                          '    Search    ',
                                          style:
                                              const TextStyle(fontSize: 18.0),
                                        )),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                        new Container(
                          alignment: Alignment.topCenter,
                          padding: new EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .18,
                              right: 0.0,
                              left: 38.0),
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
        itemBuilder: (context, index) => ListTile(
              onTap: () => onListTileTapped(locationIndex[index]),
              title: Text(locationIndex[index].toString()),
            ));
  }

  void onListTileTapped(String location) {
    textEditingController.clear();
    textEditingController.text = location;
  }
}
