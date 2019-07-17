import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  title: "firebase",
  home: Home(),
));
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text("Firebase"),
      ),
    );
  }
}

