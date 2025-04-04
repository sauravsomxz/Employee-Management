import 'package:employee_management/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'presentation/pages/employee_list_page.dart';

void main() {
  runApp(const EmployeeApp());
}

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,
          selectionColor: AppColors.textSelectionColor,
          selectionHandleColor: AppColors.primary,
        ),
      ),
      home: EmployeeListPage(),
    );
  }
}
