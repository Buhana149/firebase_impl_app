import 'package:firebase_impl_app/constants/routes.dart';
import 'package:firebase_impl_app/services/auth/auth_exceptions.dart';
import 'package:firebase_impl_app/services/auth/auth_service.dart';
import 'package:firebase_impl_app/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Login'),
      ),
      body: Column(children: [
        TextField(
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: 'Enter your email here'),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(hintText: 'Enter your password here'),
        ),
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            try {
              await AuthService.firbase().logIn(
                email: email,
                password: password,
              );

              final user = AuthService.firbase().currentUser;
              if (user?.isEmailVerified ?? false) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  notesRoute,
                  (route) => false,
                );
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  verifyEmailRoute,
                  (route) => false,
                );
              }
            } on UserNotFountAuthException {
              await showErrordialog(
                context,
                'User not found',
              );
            } on WrongPasswordAuthException {
              await showErrordialog(
                context,
                'Wrong credentials',
              );
            } on GenericAuthException {
              await showErrordialog(
                context,
                'Authentication error',
              );
            } 
          },
          child: Text('Log in'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
              (route) => false,
            );
          },
          child: Text('Not registered yet? Register here'),
        ),
      ]),
    );
  }
}