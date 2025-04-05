import 'package:employee_management/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        textCapitalization: TextCapitalization.words,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
          prefixIcon:
              prefixIcon != null
                  ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(width: 16, height: 16, child: prefixIcon),
                  )
                  : null,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.unSelectedBorderGrey),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
