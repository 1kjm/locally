import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/domain/redux/appstate.dart';

import 'package:locally/presentation/screens/directory_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Builder(
              builder: (context) => Text(store.state.myLocation),
            ),
            bottom: TabBar(
                unselectedLabelColor: Colors.indigo[200],
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.indigo, Colors.indigoAccent]),
                    color: Colors.white),
                tabs: [
                  Tab(icon: Icon(Icons.messenger_rounded)),
                  Tab(icon: Icon(Icons.library_books_rounded)),
                ]),
          ),
          body: Container(
            child: TabBarView(
              children: [
                Center(child: Container(child: Text("Coming Soon"))),
                DirectoryScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
