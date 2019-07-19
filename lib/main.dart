import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Auth - Firabase',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _imageUrl;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Board"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Text("Google-Sign-in"),
                  onPressed: () => _gSignin(),
                  color: Colors.red,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.orange,
                  child: Text("Signin with Email"),
                  onPressed: () => _signInWithEmail(),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.purple,
                  child: Text("Create Account"),
                  onPressed: () => _createUser(),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.redAccent,
                  child: Text("Logout"),
                  onPressed: () => _logout(),
                ),
              ),
              new Image.network(_imageUrl == null || _imageUrl.isEmpty
                  ? "https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true"
                  : _imageUrl)
            ],
          ),
        ));
  }

  Future<FirebaseUser> _gSignin() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    print("User is: ${user.photoUrl}");

    setState(() {
      _imageUrl = user.photoUrl;
    });

    return user;
  }

  Future _createUser() async {
    FirebaseUser user = await _auth
        .createUserWithEmailAndPassword(
        email: "ramthegreaterer@gmail.com", password: "hiltongrace2345")
        .then((userNew) {
      print("User created ${userNew.displayName}");
      print("Email: ${userNew.email}");
    });

    //print(user.email);
  }

  _logout() {
    setState(() {
      _googleSignIn.signOut();
      _imageUrl = null;
    });
  }

  _signInWithEmail() {

    _auth
        .signInWithEmailAndPassword(
        email: "ramthegreaterer@gmail.com", password: "hiltongrace2345")
        .catchError((error) {
      print("Something went wrong! ${error.toString()}");
    }).then((newUser) {
      print("User signed in: ${newUser.email}");
    });
  }
}