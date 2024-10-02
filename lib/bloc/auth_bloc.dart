import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequest);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }
}

void _onAuthLoginRequest(
  AuthLoginRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
    final email = event.email;
    final password = event.password;

    // TODO: Email Validation using Regex
    if (email.length == 0) {
      return emit(AuthFailure('Email cannot be empty'));
    }
    //password validation
    if (password.length < 3) {
      return emit(AuthFailure('Password must be 3 char long'));
    }

    await Future.delayed(const Duration(seconds: 1), () {
      emit(AuthSuccess(uid: '$email-$password'));
    });
  } catch (e) {
    return emit(AuthFailure(e.toString()));
  }
}

void _onAuthLogoutRequested(
  AuthLogoutRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
    await Future.delayed(const Duration(seconds: 1), () {
      return emit(AuthInitial());
    });
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}
