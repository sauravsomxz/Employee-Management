import 'package:employee_management/core/assets/local_assets.dart';
import 'package:employee_management/presentation/pages/employee_form_page.dart';
import 'package:flutter/material.dart';
import 'package:employee_management/core/constants/app_colors.dart';
import 'package:employee_management/core/constants/app_strings.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          AppStrings.appTitle,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: false,
      ),
      body: Center(
        child: Image.asset(ImagePaths.emptyState, height: 261, width: 244),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmployeeFormPage()),
          );
        },
        backgroundColor: AppColors.primary,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
