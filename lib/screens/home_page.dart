import 'dart:async';

import 'package:bokun_dart/widgets/navigation_drawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:bokun_dart/util/auth.dart';
import 'package:bokun_dart/widgets/auth_provider.dart';
import 'package:bokun_dart/models/user.dart';
import 'package:bokun_dart/models/match.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  User currentUser;
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
    final BaseAuth auth = AuthProvider.of(context).auth;
    return Scaffold(
      appBar: AppBar(),
      drawer: NavigationDrawer(users.where((user) => user.id == auth.currentUser()).first, _getCurrentMonthUsers, widget._signOut),
      body: Column(children: <Widget>[
        Hero(
          tag: 'bokun_logo_color',
          child: SvgPicture.asset(
            'assets/bokun-logo.svg',
            height: 80.0,
            width: 80.0,
          ),
        ),
        Container(
          child: Center(
              child: Text('Play darts', style: TextStyle(fontSize: 32.0))),
        )
      ]),
    );
  }

  List<User> _getCurrentMonthUsers() {
    List<User> usersWithScoresThisMonth = users
        .where((User user) => user.monthlyElo.containsKey(_currentMonthKey))
        .toList();
    usersWithScoresThisMonth.sort((User a, User b) {
      DartMatch lastForA = a.lastEloMatch;
      DartMatch lastForB = b.lastEloMatch;
      return lastForB.finalElo.compareTo(lastForA.finalElo);
    });

    return usersWithScoresThisMonth;
  }
}
