import 'package:firebase_database/firebase_database.dart';

class User {
  User(this._userName, this._email, this._photoUrl);

  User.fromSnapshot(DataSnapshot snapshot)
      : _userName = snapshot.value['username'],
        _email = snapshot.value['email'],
        _photoUrl = snapshot.value['photoURL'];

  User.map(dynamic obj) {
    _userName = obj['username'];
    _email = obj['email'];
    _photoUrl = obj['photoURL'];
  }

  String _userName;
  String _email;
  String _photoUrl;

  String get userName => _userName;
  String get email => _email;
  String get photoUrl => _photoUrl;
}
