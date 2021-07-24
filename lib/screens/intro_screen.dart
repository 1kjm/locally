import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/features/AutoCompleteTextField/actf_ui.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('introScreen Build');
    final store = StoreProvider.of<AppState>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 2,
                child: AutoCompleteTextField()),
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
}