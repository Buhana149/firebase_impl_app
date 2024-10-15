import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_impl_app/firebase_options.dart';
import 'package:firebase_impl_app/register_pages/login_view.dart';
import 'package:firebase_impl_app/register_pages/register_view.dart';
import 'package:firebase_impl_app/register_pages/verify_email_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;

              if (user?.emailVerified ?? false) {
                return Center(child: Text('Done'));
              } else {
                return VerifyEmailView();
              }
              // return LoginView();

            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
