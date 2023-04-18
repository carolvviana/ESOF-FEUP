import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../database_service/database_service.dart';

class Comment {
  String author_id;
  String comment;
  String? reply;

  Comment(this.author_id, this.comment, this.reply);
}

class AppDatabase extends DatabaseService {
  AppDatabase() : super();

  Future<void> writeNewComment(
      String author_id, String movieId, String comment) async {
    await pushData('comments/$movieId', {
      'author_id': author_id,
      'comment': comment,
    });
  }

  Future<void> writeCommentReply(
      String author_id, String movieId, String reply) async {
    await setData('comments/$movieId/reply', {
      'author_id': author_id,
      'comment': reply,
    });
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

  Stream<List<Map<dynamic, dynamic>>> getComments(String movieId) async* {
    DataSnapshot snapshot = await getData('comments/$movieId');
    List<Map<dynamic, dynamic>> comments = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

      for (var entry in values.entries) {
        String username = await getUsername(entry.value['author_id']);
        Map<dynamic, dynamic> comment = {
          'user': username,
          'comment': entry.value['comment'],
          'reply': entry.value['reply'] ?? '',
        };
        comments.add(comment);
        yield comments.toList();
      }
      ;
    }
    // return comments;
  }
}
