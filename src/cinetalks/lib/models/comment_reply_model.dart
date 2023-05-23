import 'package:firebase_database/firebase_database.dart';

class Reply {
  String username;
  String text;

  Reply(this.username, this.text);
}

class Comment {
  late final DatabaseReference ref;
  String username;
  String text;
  List<Reply> replies = [];

  Comment(this.username, this.text);
}
