import 'package:employee_management/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class QuickSelectButton extends StatelessWidget {
  final String label;
  final int daysToAdd;
  final DateTime? selectedDate;
  final Function(int) onTap;
  final bool isNoDate;

  const QuickSelectButton({
    super.key,
    required this.label,
    required this.daysToAdd,
    required this.selectedDate,
    required this.onTap,
    this.isNoDate = false,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime targetDate = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(Duration(days: daysToAdd));

    bool isSelected = false;

    if (isNoDate) {
      isSelected = selectedDate == null;
    } else {
      isSelected =
          selectedDate != null &&
          selectedDate!.year == targetDate.year &&
          selectedDate!.month == targetDate.month &&
          selectedDate!.day == targetDate.day;
    }

    return TextButton(
      onPressed: () => onTap(daysToAdd),
      style: TextButton.styleFrom(
        backgroundColor:
            isSelected ? AppColors.primary : AppColors.cancelButtonBg,
        foregroundColor: isSelected ? AppColors.white : AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isSelected ? AppColors.white : null,
        ),
      ),
    );
  }
}
