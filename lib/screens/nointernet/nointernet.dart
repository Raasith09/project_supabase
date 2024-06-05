import 'package:flutter/material.dart';
import 'package:project_supabase/utils/sized_box.dart';
import 'package:project_supabase/core/connectivity.dart';

class Nointernet extends StatelessWidget {
  const Nointernet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/flat-vector-no-connection-concept-illustration_939213-460.avif",
              height: 230,
              width: 230,
            ),
          ),
          30.kH,
          const Text(
            "No Internet Connection",
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
                    final bool isConnected = await checkConnectivity();
                    if (isConnected) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Still there is no internet, try again",
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("Try Again")))
        ],
      ),
    );
  }
}
