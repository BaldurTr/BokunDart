import 'package:flutter/material.dart';
import 'package:bokun_dart/util/auth.dart';
import 'package:bokun_dart/widgets/auth_provider.dart';
import 'package:bokun_dart/screens/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Bokun Dart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(),
      ),
    );
  }
}
