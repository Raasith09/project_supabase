import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_supabase/core/shared_preference.dart';
import 'package:project_supabase/screens/error/error_page.dart';
import 'package:project_supabase/screens/home/ui/home.dart';
import 'package:project_supabase/screens/nointernet/nointernet.dart';
import 'package:project_supabase/screens/sign_in/bloc/auth_bloc.dart';
import 'package:project_supabase/screens/sign_up/sign_up.dart';
import 'package:project_supabase/utils/colors.dart';
import 'package:project_supabase/utils/sized_box.dart';
import 'package:project_supabase/widgets/custom_checkbox.dart';
import 'package:project_supabase/widgets/player_card.dart';
import 'package:project_supabase/widgets/search_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isChecked = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPref.getSharedPrefInstance();
    if (prefs.containsKey("userEmail")) {
      email.text = prefs.getString("userEmail")!;
      password.text = prefs.getString("userPassword")!;
      isChecked = prefs.getBool("remember")!;
      setState(() {});
    }
  }

  @override
  void dispose() {
    email.clear();
    password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Invalid User name or Password",
                  ),
                ),
              );
            }
            if (state is AuthSuccess) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }

            if (state is AuthWithNoInternet) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Nointernet()));
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

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    10.kH,
                    const PlayerCard(),
                    30.kH,
                    Text("Welcome, back!",
                        style: TextStyle(
                            fontSize: 34,
                            color: AppColors.highlightedTextColor,
                            fontWeight: FontWeight.w600)),
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
                    20.kH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomCheckbox(
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            10.kW,
                            Text(
                              "Remember me",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.unhighlightedTextColor),
                            )
                          ],
                        ),
                        const Text(
                          "",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue),
                        )
                      ],
                    ),
                    30.kH,
                    GestureDetector(
                      onTap: () {
                        if (email.text.isEmpty || password.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Enter Valid Credentials.",
                              ),
                            ),
                          );
                        } else {
                          context.read<AuthBloc>().add(AuthLoginRequested(
                              email: email.text,
                              password: password.text,
                              rememberPassword: isChecked));
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
                        child: const Text("Sign In",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    30.kH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account? ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.highlightedTextColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                decorationColor:
                                    AppColors.highlightedButtonColor,
                                color: AppColors.highlightedButtonColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget messageScreen(String title, Size size, bool isSuccess) {
    return Container(
      height: size.height / 1.8,
      width: size.width,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSuccess
                    ? const Color.fromARGB(255, 0, 83, 14)
                    : const Color.fromARGB(255, 83, 6, 0)),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () async {},
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green)),
              child: SizedBox(
                width: size.width,
                height: 30,
                child: Text(
                  isSuccess ? "Verify Stamps" : "Retry",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ))
        ],
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
