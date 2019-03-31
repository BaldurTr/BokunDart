import 'package:flutter/material.dart';
import 'package:login_demo/util/auth.dart';
import 'package:login_demo/widgets/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged in'),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout',
                style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          )
        ],
      ),
      body: Column(
          children: <Widget>[
            Image.asset('assets/bokun.jpg'),
            Container(
              child: Center(
                  child: Text('Play darts', style: TextStyle(fontSize: 32.0))),
            )
          ]),
    );
  }
}