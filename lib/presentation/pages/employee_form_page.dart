import 'package:employee_management/core/assets/local_assets.dart';
import 'package:employee_management/core/constants/app_colors.dart';
import 'package:employee_management/core/constants/app_strings.dart';
import 'package:employee_management/core/widgets/custom_drop_down_field.dart';
import 'package:employee_management/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EmployeeFormPage extends StatelessWidget {
  const EmployeeFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.addEmployeeDetails,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.white),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hintText: AppStrings.employeeNameHint,
              prefixIcon: Image.asset(ImagePaths.personHollowIcon),
            ),
            const SizedBox(height: 18),

            // Dropdown Placeholder
            CustomDropdownField<String>(
              hintText: AppStrings.selectRoleHint,
              items: [],
              onChanged: (val) {},
              prefixIcon: Image.asset(ImagePaths.briefcaseHollowIcon),
            ),
            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: AppStrings.todayHint,
                    prefixIcon: Image.asset(ImagePaths.calendarHollowIcon),
                    readOnly: true,
                  ),
                ),
                SizedBox(width: 16),
                Image.asset(ImagePaths.arrowRightIcon, height: 20, width: 20),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    hintText: AppStrings.noDateHint,
                    prefixIcon: Image.asset(ImagePaths.calendarHollowIcon),
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: AppColors.cancelButtonBg,
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
