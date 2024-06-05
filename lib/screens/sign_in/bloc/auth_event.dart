// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  String email;
  String password;
  bool rememberPassword;
  AuthLoginRequested({
    required this.email,
    required this.password,
    required this.rememberPassword,
  });
}

class AuthSignUpRequested extends AuthEvent {
  String email;
  String password;
  String name;
  AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.name,
  });
}

class AuthLogoutRequested extends AuthEvent {}
