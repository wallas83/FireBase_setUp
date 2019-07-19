import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth-Firebase',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Board-auth"),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text("Google-Sign In"),
                  onPressed: () => _gSignIn(),
                  color: Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text("Sig In with Email"),
                  color: Colors.blueAccent,
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text("Create Account"),
                  color: Colors.purpleAccent,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ));
  }

  Future<FirebaseUser>_gSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
    print("user is :${user.displayName}");
  }
}

//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  List<Board> boardMessages = List();
//  Board board;
//  final FirebaseDatabase database = FirebaseDatabase.instance;
//  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
//  DatabaseReference databaseReference;
//
//  @override
//  void initState() {
//    super.initState();
//    board = Board("", "");
//    databaseReference = database.reference().child("community_board");
//    databaseReference.onChildAdded.listen(_onEntryAdded);
//    databaseReference.onChildAdded.listen(_onEntryChanged);
//  }
//
//  //  void _incrementCounter() {
////    //setting a map to firebase whit the method set
////    database
////        .reference()
////        .child("message")
////        .set({"firstname": "wilson", "lastname": "huanca", "Age": "24"});
////    setState(() {
////      database
////          .reference()
////          .child("message")
////          .once()
////          .then((DataSnapshot snapshot) {
////        Map<dynamic, dynamic> data = snapshot.value;
////
////        print("values from firebase DB ${data.values}");
////      });
////      _counter++;
////    });
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text("Board"),
//        ),
//        body: Column(
//          children: <Widget>[
//            Flexible(
//              flex: 0,
//              child: Center(
//                child: Form(
//                  key: formkey,
//                  child: Flex(
//                    direction: Axis.vertical,
//                    children: <Widget>[
//                      ListTile(
//                        leading: Icon(Icons.subject),
//                        title: TextFormField(
//                          initialValue: "",
//                          onSaved: (val) => board.subjet = val,
//                          validator: (val) => val == "" ? val : null,
//                        ),
//                      ),
//                      ListTile(
//                        leading: Icon(Icons.message),
//                        title: TextFormField(
//                          initialValue: "",
//                          onSaved: (val) => board.body = val,
//                          validator: (val) => val == "" ? val : null,
//                        ),
//                      ),
//                      //send or post button
//                      FlatButton(
//                        child: Text("post"),
//                        color: Colors.redAccent,
//                        onPressed: () {
//                          handleSubmit();
//                        },
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            ),
//            Flexible(
//              //getting the data from firebase
//              child: FirebaseAnimatedList(
//                query: databaseReference,
//                itemBuilder: (_, DataSnapshot snapshot,
//                    Animation<double> animation, int index) {
//                  return new Card(
//
//                    child: ListTile(
//                      leading: CircleAvatar(
//                        backgroundColor: Colors.redAccent,
//                      ),
//                      title: Text(boardMessages[index].subjet),
//                      subtitle: Text(boardMessages[index].body),
//                    ),
//                  );
//                },
//              ),
//            )
//          ],
//        ));
//  }
//
//  void _onEntryAdded(Event event) {
//    setState(() {
//      boardMessages.add(Board.fromSnapshot(event.snapshot));
//    });
//  }
//
//  void handleSubmit() {
//    final FormState form = formkey.currentState;
//    if (form.validate()) {
//      form.save();
//      form.reset();
//      // save form data to database
//      // create a unique key
//      databaseReference.push().set(board.toJson());
//    }
//  }
//
//  void _onEntryChanged(Event event) {
//    var oldEntry = boardMessages.singleWhere((entry){
//      return entry.key == event.snapshot.key;
//    });
//    setState(() {
//      boardMessages[boardMessages.indexOf(oldEntry)] = Board.fromSnapshot(event.snapshot);
//    });
//  }
//}
