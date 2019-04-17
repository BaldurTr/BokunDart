import 'package:bokun_dart/widgets/leaderboard_tile.dart';
import 'package:flutter/material.dart';
import 'package:bokun_dart/models/user.dart';

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
              return LeaderBoardTile(
                user: users[position],
              );
            }),
      ),
    );
  }
}
