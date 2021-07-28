import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/features/AutoCompleteTextField/actf_redux_actions.dart';
import 'package:locally/features/AutoCompleteTextField/actf_ui.dart';

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
        body: FutureBuilder(
            initialData: true,
            future: store.state.hasLocationIndexData,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              print('intro' + snapshot.data.toString());
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.red,
                ));
              } else if (snapshot.hasData) {
                return snapshot.data!
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Expanded(
                              child: AutoCompleteTextField(),
                              flex: 1,
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Text('Unknown Error Please Restart the app'),
                      );
              }
              return Container();
            }),
      ),
    );
  }
}
