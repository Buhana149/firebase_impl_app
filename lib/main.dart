import 'package:firebase_impl_app/constants/routes.dart';
import 'package:firebase_impl_app/home_page.dart';
import 'package:firebase_impl_app/services/auth/bloc/auth_bloc.dart';
import 'package:firebase_impl_app/services/auth/firebase_auth_provider.dart';
import 'package:firebase_impl_app/views/login_view.dart';
import 'package:firebase_impl_app/views/notes/create_update_note_view.dart';
import 'package:firebase_impl_app/views/notes/notes_view.dart';
import 'package:firebase_impl_app/views/register_view.dart';
import 'package:firebase_impl_app/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    );
  }
}
