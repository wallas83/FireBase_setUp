import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_setup/model/board.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List<Board> boardMessages = List();
  Board board;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  @override
  void initState() {
      super.initState();
      board = Board("","");
      databaseReference = database.reference().child("community_board");
      databaseReference.onChildAdded.listen(_onEntryAdded);
  }
  //  void _incrementCounter() {
//    //setting a map to firebase whit the method set
//    database
//        .reference()
//        .child("message")
//        .set({"firstname": "wilson", "lastname": "huanca", "Age": "24"});
//    setState(() {
//      database
//          .reference()
//          .child("message")
//          .once()
//          .then((DataSnapshot snapshot) {
//        Map<dynamic, dynamic> data = snapshot.value;
//
//        print("values from firebase DB ${data.values}");
//      });
//      _counter++;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Board"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Form(
              key: formkey,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.subject),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) =>board.subjet = val,
                      validator: (val) => val == "" ? val : null,

                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => board.body = val,
                      validator: (val) => val == ""? val : null,
                    ),
                  ),
                  //send or post button
                  FlatButton(
                    child: Text("post"),
                    color: Colors.redAccent,
                    onPressed: (){
                      handleSubmit();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )

    );
  }

  void _onEntryAdded(Event event) {
    setState(() {
      boardMessages.add(Board.fromSnapshot(event.snapshot));
    });
  }

  void handleSubmit() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      // save form data to database

      databaseReference.push().set(board.toJson());
    }
  }
}
