import 'package:firebase_impl_app/services/auth/bloc/auth_bloc.dart';
import 'package:firebase_impl_app/services/auth/bloc/auth_events.dart';
import 'package:firebase_impl_app/services/auth/bloc/auth_state.dart';
import 'package:firebase_impl_app/views/login_view.dart';
import 'package:firebase_impl_app/views/notes/notes_view.dart';
import 'package:firebase_impl_app/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState >(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
