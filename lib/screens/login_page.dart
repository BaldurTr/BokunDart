import 'package:flutter/material.dart';
import 'package:bokun_dart/util/auth.dart';
import 'package:bokun_dart/widgets/auth_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          final String userId =
              await auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        } else {
          final String userId =
              await auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  final Hero logo = Hero(
    tag: 'bokun_logo_color',
    child: SvgPicture.asset(
      'assets/bokun-logo.svg',
      height: 80.0,
      width: 80.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      body: Container(
//        decoration: BoxDecoration(
//            image: DecorationImage(
//                image:
//                    AssetImage('assets/daniel-leone-185834-unsplash-1920.jpg'),
//                fit: BoxFit.cover)),
//        padding: EdgeInsets.all(16.0),
//        child: Form(
//          key: formKey,
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: buildInputs() + buildSubmitButtons(),
//          ),
//        ),
//      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Form(
          key: formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: createLoginForm(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> createLoginForm() {
    List<Widget> items = <Widget>[
      logo,
      SizedBox(
        height: 68.0,
      ),
      email(),
      SizedBox(
        height: 28.0,
      ),
      password(),
      SizedBox(
        height: 28.0,
      ),
    ];
    items.addAll(buildSubmitButtons());
    return items;
  }

  Widget email() {
    return TextFormField(
      key: Key('email'),
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: EmailFieldValidator.validate,
      onSaved: (String value) => _email = value,
    );
  }

  Widget password() {
    return TextFormField(
      key: Key('password'),
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      obscureText: true,
      validator: PasswordFieldValidator.validate,
      onSaved: (String value) => _password = value,
    );
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              key: Key('signIn'),
              child: Text('Login', style: TextStyle(fontSize: 20.0)),
              onPressed: validateAndSubmit,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: FlatButton(
              child:
                  Text('Create an account', style: TextStyle(fontSize: 20.0)),
              onPressed: moveToRegister,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            )),
      ];
    } else {
      return <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child:
                  Text('Create an account', style: TextStyle(fontSize: 20.0)),
              onPressed: validateAndSubmit,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: FlatButton(
              child: Text('Have an account? Login',
                  style: TextStyle(fontSize: 20.0)),
              onPressed: moveToLogin,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            )),
      ];
    }
  }
}
