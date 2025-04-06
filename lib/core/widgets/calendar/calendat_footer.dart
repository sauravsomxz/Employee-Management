import 'package:employee_management/core/assets/local_assets.dart';
import 'package:employee_management/core/constants/app_colors.dart';
import 'package:employee_management/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarFooter extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime?) onDateSelected;

  const CalendarFooter({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(ImagePaths.calendarHollowIcon, height: 24, width: 24),
            const SizedBox(width: 4),
            Text(
              selectedDate != null
                  ? DateFormat('dd MMM yyyy').format(selectedDate!)
                  : AppStrings.noDateHint,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.cancelButtonBg,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                AppStrings.cancel,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onDateSelected(
                  selectedDate,
                ); // <-- This will be null if "No Date" tapped
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                AppStrings.save,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
