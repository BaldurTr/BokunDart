import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_demo/util/auth.dart';
import 'package:login_demo/widgets/auth_provider.dart';
import 'package:login_demo/screens/leaderboard_page.dart';
import 'package:login_demo/models/user.dart';
import 'package:login_demo/models/match.dart';

class HomePage extends StatefulWidget {
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
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<User> users;
  StreamSubscription<Event> _onUserAddedSubscription;
  String _currentMonthKey;

  final DatabaseReference usersReference =
      FirebaseDatabase.instance.reference().child('users');

  @override
  void initState() {
    super.initState();

    final DateTime currentDate = DateTime.now();
    _currentMonthKey = '${currentDate.year}-${currentDate.month - 1}';
    users = <User>[];
    _onUserAddedSubscription = usersReference.onChildAdded.listen(_onUserAdded);
  }

  void _onUserAdded(Event event) {
    setState(() {
      users.add(User.fromSnapshot(event.snapshot));
    });
  }

  @override
  void dispose() {
    _onUserAddedSubscription.cancel();
    super.dispose();
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
            onPressed: () => widget._signOut(context),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Leaderboard'),
              onTap: () {
                print(_currentMonthKey);
                Navigator.push(
                    context,
                    MaterialPageRoute<LeaderBoard>(
                        builder: (BuildContext context) => LeaderBoard(
                              users: _getCurrentMonthUsers(),
                            )));
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: Column(children: <Widget>[
        Image.asset('assets/bokun.jpg'),
        Container(
          child: Center(
              child: Text('Play darts', style: TextStyle(fontSize: 32.0))),
        )
      ]),
    );
  }

  List<User> _getCurrentMonthUsers() {
    List<User> usersWithScoresThisMonth = users.where((User user) => user.monthlyElo.containsKey(_currentMonthKey)).toList();
    usersWithScoresThisMonth.sort((User a, User b) {
      DartMatch lastForA = a.lastEloMatch;
      DartMatch lastForB = b.lastEloMatch;
      return lastForB.finalElo.compareTo(lastForA.finalElo);
    });

    return usersWithScoresThisMonth;
  }
}
