import 'package:flutter/material.dart';
import 'package:project_supabase/utils/colors.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData myIcons;
  const SearchInput(
      {required this.textController,
      required this.hintText,
      super.key,
      required this.myIcons});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onChanged: (value) {},
      decoration: InputDecoration(
        prefixIcon: Icon(
          myIcons,
          color: AppColors.unhighlightedTextColor,
        ),
        filled: true,
        fillColor: AppColors.secondaryThemeColor,
        hintText: hintText,
        hintStyle: TextStyle(
            color: AppColors.unhighlightedTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w600),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }
}
