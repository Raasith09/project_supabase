import 'package:flutter/material.dart';

import 'package:project_supabase/utils/sized_box.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/404-error-3640001-3040129.webp",
              height: 230,
              width: 230,
            ),
          ),
          30.kH,
          const Text(
            "Something went wrong, try again later",
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          30.kH,
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Text color
                    elevation: 5, // Shadow elevation
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30), // Button padding
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text("Try Again")))
        ],
      ),
    );
  }
}
