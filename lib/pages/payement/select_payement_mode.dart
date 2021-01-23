import 'package:flutter/material.dart';

class SelectPayementMode extends StatefulWidget {
  @override
  _SelectPayementModeState createState() => _SelectPayementModeState();
}

class _SelectPayementModeState extends State<SelectPayementMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Selection du pack de payement"),
        ),
      ),
    );
  }
}
