import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/features/AutoCompleteTextField/data/redux/actions.dart';
import 'package:locally/features/AutoCompleteTextField/presentation/ui.dart';

import 'package:locally/redux/appstate.dart';

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
    store.dispatch(GetLocationIndex());
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: AutoCompleteTextField(),
                  flex: 1,
                ),
              ],
            ),
          )),
    );
  }
}
