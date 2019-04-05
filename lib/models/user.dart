class User {

  User(this._userName, this._email, this._photoUrl);

  String _userName;
  String _email;
  String _photoUrl;

  String get userName => _userName;
  String get email => _email;
  String get photoUrl => _photoUrl;

}