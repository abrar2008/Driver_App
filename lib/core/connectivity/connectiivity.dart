import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class Checkinternetconnectivity extends StatefulWidget {
  const Checkinternetconnectivity({Key key}) : super(key: key);

  @override
  _CheckinternetconnectivityState createState() =>
      _CheckinternetconnectivityState();
}

class _CheckinternetconnectivityState extends State<Checkinternetconnectivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _connectivity(),
    );
  }

  _connectivity() async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
    } else if (result == ConnectivityResult.mobile) {
    } else if (result == ConnectivityResult.wifi) {}
  }

  _showdialogue() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Hello"),
          );
        });
  }
}
