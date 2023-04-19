import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  Future<void> setData(String path, Map<String, dynamic> data) async {
    await databaseReference.child(path).set(data);
  }

  Future<void> pushData(String path, Map<String, dynamic> data) async {
    await databaseReference.child(path).push().set(data);
  }

  Future<DataSnapshot> getData(String path) async {
    return await databaseReference
        .child(path)
        .once()
        .then((event) => event.snapshot);
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    await databaseReference.child(path).update(data);
  }

  Future<void> deleteData(String path) async {
    await databaseReference.child(path).remove();
  }
}
