import 'package:firebase_database/firebase_database.dart';

import '../database_service/database_service.dart';

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
}
