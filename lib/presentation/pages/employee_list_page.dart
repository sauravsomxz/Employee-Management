import 'package:employee_management/core/assets/local_assets.dart';
import 'package:employee_management/cubit/employee_form_cubit.dart';
import 'package:employee_management/presentation/pages/employee_form_page.dart';
import 'package:employee_management/presentation/widgets/employee_tile.dart';
import 'package:employee_management/repository/employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:employee_management/core/constants/app_colors.dart';
import 'package:employee_management/core/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: ValueListenableBuilder(
        valueListenable: EmployeeRepository.currentEmployees,
        builder: (context, current, _) {
          return ValueListenableBuilder(
            valueListenable: EmployeeRepository.previousEmployees,
            builder: (context, previous, _) {
              if (current.isEmpty && previous.isEmpty) {
                return Center(
                  child: Image.asset(
                    ImagePaths.emptyState,
                    height: 261,
                    width: 244,
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (current.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: AppColors.headingBgColor,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14.0, left: 8.0),
                        child: const Text(
                          'Current Employees',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    ...current.asMap().entries.map((entry) {
                      final index = entry.key;
                      final employee = entry.value;
                      final isLast = index == current.length - 1;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EmployeeCard(
                            employee: employee,
                            onDelete:
                                () =>
                                    EmployeeRepository.deleteEmployee(employee),
                            index: index,
                          ),
                          if (!isLast) const Divider(height: 0),
                        ],
                      );
                    }),
                  ],
                  if (previous.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: AppColors.headingBgColor,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14.0, left: 8.0),
                        child: const Text(
                          'Previous Employees',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    ...previous.asMap().entries.map((entry) {
                      final index = entry.key;
                      final employee = entry.value;
                      final isLast = index == previous.length - 1;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EmployeeCard(
                            employee: employee,
                            onDelete:
                                () =>
                                    EmployeeRepository.deleteEmployee(employee),
                            index: index,
                          ),
                          if (!isLast) const Divider(height: 0),
                        ],
                      );
                    }),
                  ],
                ],
              );
            },
          );
        },
      ),

      bottomNavigationBar: Container(
        height: 100,
        color: AppColors.headingBgColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0),
          child: Text(
            "Swipe to delete",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: AppColors.textColor,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider(
                    create: (_) => EmployeeFormCubit(),
                    child: const EmployeeFormPage(),
                  ),
            ),
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
