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
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      title: Text(
        employee.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            employee.role.label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF949C9E),
            ),
          ),
          const SizedBox(height: 4),
          if (employee.isCurrent) ...[
            Text(
              'From ${DateFormat('dd MMM, yyyy').format(employee.startDate)}',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFF949C9E),
              ),
            ),
          ],
          if (!employee.isCurrent)
            Text(
              '${DateFormat('dd MMM, yyyy').format(employee.startDate)} - ${DateFormat('dd MMM, yyyy').format(employee.endDate!)}',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFF949C9E),
              ),
            ),
        ],
      ),
    );
  }
}
