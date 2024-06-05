import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_supabase/core/connectivity.dart';
import 'package:project_supabase/core/shared_preference.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/authentication_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(loginSubmitEvent);
    on<AuthSignUpRequested>(signUpSubmitEvent);
  }
// => Auth LogIn Event
  FutureOr<void> loginSubmitEvent(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    final String email = event.email;
    final String password = event.password;
    final bool isChecked = event.rememberPassword;

    try {
      final bool isConnected = await checkConnectivity();
      emit(AuthLoading());
      if (isConnected) {
        String? loginSuccess = await AuthenticationService()
            .logIn(email: email, password: password);

        debugPrint('Login successful: $loginSuccess');

        if (loginSuccess == "success") {
          emit(AuthSuccess());
          if (event.rememberPassword == true) {
            var prefs = await SharedPref.getSharedPrefInstance();
            prefs.setString("userEmail", email);
            prefs.setString("userPassword", password);
            prefs.setBool("remember", isChecked);
          }
        } else {
          emit(AuthFailure("Login failed"));
        }
      } else {
        emit(AuthWithNoInternet());
      }
    } on AuthException catch (e) {
      emit(AuthFailure(e.message.toString()));
    } catch (e) {
      emit(AuthError());
    }
  }

// Auth SignUp Event

  FutureOr<void> signUpSubmitEvent(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    final String email = event.email;
    final String password = event.password;
    final String name = event.name;

    try {
      final bool isConnected = await checkConnectivity();
      emit(AuthLoading());
      if (isConnected) {
        final signUpSuccess = await AuthenticationService()
            .signUp(email: email.trim(), password: password.trim());

        debugPrint('signUp successful: $signUpSuccess');

        if (signUpSuccess == "success") {
          emit(AuthSuccess());

          var prefs = await SharedPref.getSharedPrefInstance();
          prefs.setString("email", email);
          prefs.setString("password", password);
          prefs.setString("name", name);
        } else {
          emit(AuthFailure("Login failed"));
        }
      } else {
        emit(AuthWithNoInternet());
      }
    } on AuthException catch (e) {
      emit(AuthFailure(e.message.toString()));
    } catch (e) {
      emit(AuthError());
    }
  }
}
