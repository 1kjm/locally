import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/model/destination_model.dart';
import 'package:locally/redux/Routes/navigation_action.dart';

import 'package:locally/redux/appstate.dart';
import 'package:locally/redux/initialRunChecker/initial_run_check_actions.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final TextEditingController textEditingController = TextEditingController();

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
    final store = StoreProvider.of<AppState>(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textBar(),
            IconButton(
                onPressed: () async {
                  await store.dispatch(ChangeInitialRunCheckValue());
                  store.dispatch(
                      NavigateToNext(destination: Destination.HOMEPAGE));
                },
                icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }

  Widget textBar() {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(5),
        child: Container(
          padding: EdgeInsets.all(3),
          child: TextField(
            onChanged: (value) {},
            controller: textEditingController,
            keyboardType: TextInputType.name,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'Search'),
          ),
        ));
  }
}
