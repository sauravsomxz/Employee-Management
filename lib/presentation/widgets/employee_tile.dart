import 'package:employee_management/core/constants/app_colors.dart';
import 'package:employee_management/core/constants/app_enums.dart';
import 'package:employee_management/data/models/employee_model.dart';
import 'package:employee_management/repository/employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final int index;
  final VoidCallback onDelete;

  const EmployeeCard({
    super.key,
    required this.employee,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(employee.key),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (_) {
              final deletedEmployee = employee;
              final deletedIndex = index;

              onDelete();

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Employee data has been deleted'),
                  duration: const Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      EmployeeRepository.insertEmployeeAt(
                        deletedEmployee,
                        deletedIndex,
                      );
                    },
                  ),
                ),
              );
            },
            backgroundColor: Colors.red,
            // foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: ListTile(
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
            if (employee.isCurrent)
              Text(
                'From ${DateFormat('dd MMM, yyyy').format(employee.startDate)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF949C9E),
                ),
              )
            else
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
      ),
    );
  }
}
