import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locally/redux/Routes/navigation_action.dart';

import 'package:locally/redux/appstate.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);
  Future<bool> onBackPressed(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(NavigateBack());
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => onBackPressed(context),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: Colors.white60,
            height: size.height,
            width: size.width,
            child: StoreConnector<AppState, List>(
                converter: (store) => store.state.tempContacts.toList(),
                builder: (context, vm) {
                  return Column(
                    children: [
                      Container(
                        height: size.height * 0.3,
                        width: size.width,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.blueAccent,
                                      Colors.purpleAccent
                                    ]),
                                    color: Colors.blueAccent),
                                child: Icon(
                                  vm.first.people ? Icons.people : Icons.store,
                                  size: 100,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  vm.first.name.toString(),
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 50.0, color: Colors.black),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 10,
                              child: Container(
                                child: IconButton(
                                  onPressed: () => onBackPressed(context),
                                  icon: Icon(
                                    Icons.arrow_back_rounded,
                                    size: 35.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          width: size.width,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                child: Card(
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                  child: ListTile(
                                      onTap: () => _callNumber(
                                          vm.first.phoneNumber.toString()),
                                      title: Text(
                                        vm.first.phoneNumber.toString(),
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      trailing: Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                              Container(
                                child: Card(
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                  child: ListTile(
                                    leading: vm.first.people
                                        ? Icon(Icons.people_rounded)
                                        : Icon(Icons.store),
                                    title: Text(
                                      vm.first.designation,
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  void _callNumber(String phoneNumber) async {
    String url = "tel://" + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phoneNumber';
    }
  }
}
