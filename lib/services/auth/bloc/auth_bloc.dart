import 'package:bloc/bloc.dart';
import 'package:firebase_impl_app/services/auth/auth_provider.dart';
import 'package:firebase_impl_app/services/auth/bloc/auth_events.dart';
import 'package:firebase_impl_app/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    on<AuthEventInitialize>(
      (event, emit) async {
        provider.initialize();
        final user = provider.currentUser;
        if (user == null) {
          emit(const AuthStateLoggedOut());
        } else if (!user.isEmailVerified) {
          emit(const AuthStateNeedsVerification());
        } else {
          emit(AuthStateLoggedIn(user));
        }
      },
    );
    on<AuthEventsLogIn>(
      (event, emit) async {
        emit(const AuthStateLoading());
        final email = event.email;
        final password = event.password;
        try {
          final user = await provider.logIn(
            email: email,
            password: password,
          );
          emit(AuthStateLoggedIn(user));
        } on Exception catch (e) {
          emit(AuthStateLoginFailure(e));
        }
      },
    );
    on<AuthEventLogOut>(
      (event, emit) async {
        emit(const AuthStateLoading());
        await provider.logOut();
        emit(const AuthStateLoggedOut());
        try {
          emit(const AuthStateLoading());
        } on Exception catch (e) {
          emit(AuthStateLogoutFailure(e));
        }
      },
    );
  }
}
