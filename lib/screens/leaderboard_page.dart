import 'package:flutter/material.dart';
import 'package:login_demo/models/user.dart';

class LeaderBoard extends StatelessWidget {

  const LeaderBoard({this.users});

  final List<User> users;

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
                    dense: true,
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('${users[position].photoUrl}'),
                    ),
                    title: Text('${users[position].userName}'),
                    subtitle: Text('Elo: ${users[position].lastEloMatch.finalElo}'),
                  ),
                  Divider(
                    height: 2.0,
                    color: Colors.grey,
                  )
                ],
              );
            }),
      ),
    );
  }
}
