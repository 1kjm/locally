import 'package:flutter/material.dart';

import 'package:locally/presentation/screens/directory_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Builder(
              builder: (context) => Text('Athirampuzha'),
            ),
            bottom: TabBar(
                unselectedLabelColor: Colors.redAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.redAccent, Colors.orangeAccent]),
                    color: Colors.redAccent),
                tabs: [
                  Tab(icon: Icon(Icons.messenger_rounded)),
                  Tab(icon: Icon(Icons.library_books_rounded)),
                ]),
          ),
          body: Container(
            child: TabBarView(
              children: [Icon(Icons.flight, size: 350), DirectoryScreen()],
            ),
          ),
        ),
      ),
    );
  }
}
