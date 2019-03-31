import 'package:flutter/material.dart';
import 'package:login_demo/util/auth.dart';
import 'package:login_demo/widgets/auth_provider.dart';
import 'package:login_demo/screens/root_page.dart';

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
