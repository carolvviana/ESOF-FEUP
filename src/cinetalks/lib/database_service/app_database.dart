import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../database_service/database_service.dart';
import '../models/movie_model.dart';

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

  Future<void> addToFavorites(
      String uid, String movieId, String movieTitle, String imagePath) async {
    await pushData('users/$uid/favorites', {
      'movieId': movieId,
      'title': movieTitle,
      'imagePath': imagePath,
    });
  }

  Future<void> removeFromFavorites(String uid, String movieId) async {
    DataSnapshot snapshot = await getData('users/$uid/favorites');
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

    for (var entry in values.entries) {
      if (entry.value['movieId'] == movieId) {
        await deleteData('users/$uid/favorites/${entry.key}');
      }
    }
  }

  Future<bool> isFavorite(String uid, String movieId) async {
    DataSnapshot snapshot = await getData('users/$uid/favorites');
    if (snapshot.value == null) return false;

    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

    for (var entry in values.entries) {
      if (entry.value['movieId'] == movieId) {
        return true;
      }
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getFavorites(String uid) async {
    DataSnapshot snapshot = await getData('users/$uid/favorites');
    List<Map<String, dynamic>> favorites = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

      for (var entry in values.entries) {
        Map<String, dynamic> movie = {
          'id': entry.value['movieId'],
          'title': entry.value['title'],
          'imagePath': entry.value['imagePath'],
        };

        favorites.add(movie);
      }
      ;
    } else {
      return [];
    }

    return favorites;
  }

  Future<void> addToWatchlist(
      String uid, String movieId, String movieTitle, String imagePath) async {
    await pushData('users/$uid/watchlist', {
      'movieId': movieId,
      'title': movieTitle,
      'imagePath': imagePath,
    });
  }

  Future<void> removeFromWatchlist(String uid, String movieId) async {
    DataSnapshot snapshot = await getData('users/$uid/watchlist');
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

    for (var entry in values.entries) {
      if (entry.value['movieId'] == movieId) {
        await deleteData('users/$uid/watchlist/${entry.key}');
      }
    }
  }

  Future<bool> isInWatchlist(String uid, String movieId) async {
    DataSnapshot snapshot = await getData('users/$uid/watchlist');
    if (snapshot.value == null) return false;
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

    for (var entry in values.entries) {
      if (entry.value['movieId'] == movieId) {
        return true;
      }
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getWatchlist(String uid) async {
    DataSnapshot snapshot = await getData('users/$uid/watchlist');
    List<Map<String, dynamic>> watchlist = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

      for (var entry in values.entries) {
        Map<String, dynamic> movie = {
          'id': entry.value['movieId'],
          'title': entry.value['title'],
          'imagePath': entry.value['imagePath'],
        };

        watchlist.add(movie);
      }
      ;
    } else {
      return [];
    }

    return watchlist;
  }
}
