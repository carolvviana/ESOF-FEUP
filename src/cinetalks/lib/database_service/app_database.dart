import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../database_service/database_service.dart';

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

class AppDatabase extends DatabaseService {
  AppDatabase() : super();

  Future<void> writeNewComment(
      String movieId, Comment comment, String author_id) async {
    // Write the new comment's data and save its reference
    await pushData('comments/$movieId', {
      'author_id': author_id,
      'comment': comment.text,
    });
  }

  Future<void> replyToComment(
      String movie_id, Comment comment, Reply reply) async {
    await pushData('comments/$movie_id/${comment.ref.key}/replies', {
      'author_id': reply.username,
      'reply': reply.text,
    });
  }

  Future<List<Comment>> getComments(String movieId) async {
    DataSnapshot snapshot = await getData('comments/$movieId');
    List<Comment> comments = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

      for (var entry in values.entries) {
        String username = await getUsername(entry.value['author_id']);

        Comment comment = Comment(
          username,
          entry.value['comment'],
        );

        comment.ref = databaseReference.child(entry.key);
        comment.replies = await getReplies(movieId, comment);

        comments.add(comment);
      }
      ;
    }

    return comments;
  }

  Future<List<Reply>> getReplies(String movie_id, Comment comment) async {
    DataSnapshot snapshot =
        await getData('comments/$movie_id/${comment.ref.key}/replies');
    List<Reply> replies = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

      for (var entry in values.entries) {
        String username = await getUsername(entry.value['author_id']);

        Reply reply = Reply(
          username,
          entry.value['reply'],
        );

        replies.add(reply);
      }
      ;
    }

    return replies;
  }

  Future<void> addUser(String uid, String username) async {
    await setData('users/$uid', {
      'username': username,
    });
  }

  Future<String> getUsername(String uid) async {
    DataSnapshot snapshot = await getData('users/$uid/username');
    return snapshot.value.toString();
  }
}
