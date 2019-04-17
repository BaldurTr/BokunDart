import 'package:bokun_dart/models/user.dart';
import 'package:bokun_dart/screens/leaderboard_page.dart';
import 'package:bokun_dart/widgets/drawer_item.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer([this._user, this._getCurrentMonthUsers, this._signOut]);
  final User _user;
  final Function _getCurrentMonthUsers;
  final Function _signOut;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(_user.userName),
            accountEmail: Text(_user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? Colors.blue : Colors.white,
              backgroundImage: NetworkImage(_user.photoUrl),
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          DrawerItem<LeaderBoard>(
            'Leaderboard',
            LeaderBoard(
              users: _getCurrentMonthUsers(),
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              _signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
