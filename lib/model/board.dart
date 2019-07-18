import 'package:firebase_database/firebase_database.dart';

class Board {
  String key;
  String subjet;
  String body;

  Board(this.subjet, this.body);

Board.fromSnapshot(DataSnapshot snapshot):
      key = snapshot.key,
      subjet = snapshot.value["subjet"],
      body  = snapshot.value["body"];

  toJson(){
    return{
        "subjet": subjet,
        "body" : body,
    };
 }
}