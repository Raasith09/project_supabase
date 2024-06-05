// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:project_supabase/utils/colors.dart';
import 'package:project_supabase/utils/sized_box.dart';
import 'package:project_supabase/widgets/custom_checkbox.dart';
import 'package:project_supabase/widgets/main_button.dart';
import 'package:project_supabase/widgets/search_input.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({
    super.key,
    required this.press,
    this.title,
    this.description,
  });
  final GestureTapCallback press;
  final TextEditingController? title;
  final TextEditingController? description;

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          top: 12,
          right: 20,
          left: 25,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            20.kH,
            SearchInput(
              textController: widget.title!,
              hintText: "Email",
              myIcons: Icons.email,
            ),
            20.kH,
            SearchInput(
              textController: widget.description!,
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
            BouncingButton(onTap: widget.press, text: "Sign In"),
            30.kH,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Don't have account? ",
            //       style: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           color: AppColors.highlightedTextColor),
            //     ),
            //     Text(
            //       "Sign Up",
            //       style: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           color: AppColors.highlightedButtonColor),
            //     )
            //   ],
            // ),
            // 40.kH,
          ],
        ),
      ),
    );
  }
}
