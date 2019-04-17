import 'package:bokun_dart/models/user.dart';
import 'package:flutter/material.dart';

class LeaderBoardTile extends StatelessWidget {

  const LeaderBoardTile({this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          leading: CircleAvatar(
            backgroundImage:
            NetworkImage('${user.photoUrl}'),
          ),
          title: Text('${user.userName}'),
          subtitle: Text('Elo: ${user.lastEloMatch.finalElo}'),
        ),
        Divider(
          height: 2.0,
          color: Colors.grey,
        )
      ],
    );
  }

}