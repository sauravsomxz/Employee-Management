import 'package:employee_management/core/constants/app_colors.dart';
import 'package:employee_management/core/constants/app_enums.dart';
import 'package:employee_management/data/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.person, color: AppColors.primary),
        title: Text(employee.name),
        subtitle: Text(
          '${employee.role.label} | ${DateFormat('dd MMM yyyy').format(employee.startDate)}'
          '${employee.endDate != null ? ' → ${DateFormat('dd MMM yyyy').format(employee.endDate!)}' : ''}',
        ),
      ),
    );
  }
}
