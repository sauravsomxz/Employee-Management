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

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (current.isNotEmpty) ...[
                    const Text(
                      'Current Employees',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...current.map((e) => EmployeeCard(employee: e)),
                    const SizedBox(height: 20),
                  ],
                  if (previous.isNotEmpty) ...[
                    const Text(
                      'Previous Employees',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...previous.map((e) => EmployeeCard(employee: e)),
                  ],
                ],
              );
            },
          );
        },
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
