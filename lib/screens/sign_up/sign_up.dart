import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_supabase/screens/error/error_page.dart';
import 'package:project_supabase/screens/home/ui/home.dart';
import 'package:project_supabase/screens/nointernet/nointernet.dart';
import 'package:project_supabase/utils/sized_box.dart';
import 'package:project_supabase/widgets/player_card.dart';
import 'package:project_supabase/widgets/search_input.dart';

import '../../utils/colors.dart';
import '../sign_in/bloc/auth_bloc.dart';
import '../sign_in/ui/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error,
                    ),
                  ),
                );
              }
              if (state is AuthSuccess) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              }
              if (state is AuthWithNoInternet) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Nointernet()));
              }
              if (state is AuthError) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ErrorPage()));
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const LoadingIndicator();
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    10.kH,
                    const PlayerCard(),
                    30.kH,
                    Text("Welcome!",
                        style: TextStyle(
                            fontSize: 34,
                            color: AppColors.highlightedTextColor,
                            fontWeight: FontWeight.w600)),
                    20.kH,
                    SearchInput(
                      textController: name,
                      hintText: "Name",
                      myIcons: Icons.person,
                    ),
                    20.kH,
                    SearchInput(
                      textController: email,
                      hintText: "Email",
                      myIcons: Icons.email,
                    ),
                    20.kH,
                    SearchInput(
                      textController: password,
                      hintText: "Password",
                      myIcons: Icons.password,
                    ),
                    30.kH,
                    GestureDetector(
                      onTap: () {
                        if (email.text.isEmpty ||
                            password.text.isEmpty ||
                            name.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Enter Valid Credentials.",
                              ),
                            ),
                          );
                        } else {
                          context.read<AuthBloc>().add(AuthSignUpRequested(
                              email: email.text,
                              password: password.text,
                              name: name.text));
                        }
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.highlightedButtonColor,
                        ),
                        child: const Text("Sign Up",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    30.kH,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
