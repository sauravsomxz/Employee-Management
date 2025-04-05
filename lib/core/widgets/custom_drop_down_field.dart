import 'package:employee_management/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final Widget? prefixIcon;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 0,
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
        icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
