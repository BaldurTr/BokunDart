

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_demo/util/auth.dart';
import 'package:login_demo/widgets/auth_provider.dart';
import 'package:login_demo/screens/login_page.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements BaseAuth {}

void main() {

  Widget makeTestableWidget({Widget child, BaseAuth auth}) {
    return AuthProvider(
      auth: auth,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('email or password is empty, does not sign in', (WidgetTester tester) async {

    final MockAuth mockAuth = MockAuth();

    bool didSignIn = false;
    final LoginPage page = LoginPage(onSignedIn: () => didSignIn = true);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await tester.tap(find.byKey(Key('signIn')));

    verifyNever(mockAuth.signInWithEmailAndPassword('', ''));
    expect(didSignIn, false);
  });

  testWidgets('non-empty email and password, valid account, call sign in, succeed', (WidgetTester tester) async {

    final MockAuth mockAuth = MockAuth();
    when(mockAuth.signInWithEmailAndPassword('email', 'password')).thenAnswer((invocation) => Future.value('uid'));

    bool didSignIn = false;
    final LoginPage page = LoginPage(onSignedIn: () => didSignIn = true);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    
    final Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email');

    final Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('signIn')));

    verify(mockAuth.signInWithEmailAndPassword('email', 'password')).called(1);
    expect(didSignIn, true);
    
  });

  testWidgets('non-empty email and password, valid account, call sign in, fails', (WidgetTester tester) async {

    final MockAuth mockAuth = MockAuth();
    when(mockAuth.signInWithEmailAndPassword('email', 'password')).thenThrow(StateError('invalid credentials'));

    bool didSignIn = false;
    final LoginPage page = LoginPage(onSignedIn: () => didSignIn = true);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    final Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email');

    final Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('signIn')));

    verify(mockAuth.signInWithEmailAndPassword('email', 'password')).called(1);
    expect(didSignIn, false);

  });

}