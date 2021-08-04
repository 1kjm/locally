import 'package:flutter/material.dart';

class CustomAlertbox extends StatelessWidget {
  CustomAlertbox({Key? key}) : super(key: key);
  final Future timer = Future.delayed(Duration(seconds: 5));
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: timer,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : AlertDialog(
                  title: Text("No Internet"),
                  content: Text("Please Check Your Internet Connection"),
                  actions: [
                    okButton,
                  ],
                ),
    );
  }

  final Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {},
  );
}
