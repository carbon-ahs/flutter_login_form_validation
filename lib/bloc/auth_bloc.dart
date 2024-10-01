import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      try {
        final email = event.email;
        final password = event.password;

        // Email Validation using Regex

        //password validation
        if (password.length < 6) {
          return emit(AuthFailure('Password must be 6 char long'));
        }

        await Future.delayed(const Duration(seconds: 1),
            () => emit(AuthSuccess(uid: '$email-$password')));
      } catch (e) {
        return emit(AuthFailure(e.toString()));
      }
    });
  }
}
