import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_demo/models/user.dart';

class LeaderBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaderBoardState();
}

final DatabaseReference usersReference =
    FirebaseDatabase.instance.reference().child('users');

class _LeaderBoardState extends State<LeaderBoard> {
  List<User> users;
  StreamSubscription<Event> _onUserAddedSubscription;

  @override
  void initState() {
    super.initState();

    users = <User>[];

    _onUserAddedSubscription = usersReference.onChildAdded.listen(_onUserAdded);
  }

  @override
  void dispose() {
    _onUserAddedSubscription.cancel();
    super.dispose();
  }

  void _onUserAdded(Event event) {
    setState(() {
      users.add(User.fromSnapshot(event.snapshot));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: users.length,
            padding: EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('${users[position].photoUrl}'),
                    ),
                    title: Text('${users[position].userName}'),
                  )
                ],
              );
            }),
      ),
    );
  }
}
