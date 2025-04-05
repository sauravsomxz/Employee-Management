import 'package:employee_management/data/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class EmployeeRepository {
  static final currentEmployees = ValueNotifier<List<Employee>>([]);
  static final previousEmployees = ValueNotifier<List<Employee>>([]);

  static void loadEmployees() {
    final box = Hive.box<Employee>('employees');
    final allEmployees = box.values.toList();

    currentEmployees.value = allEmployees.where((e) => e.isCurrent).toList();
    previousEmployees.value = allEmployees.where((e) => !e.isCurrent).toList();
  }

  static Future<void> addEmployee(Employee employee) async {
    final box = Hive.box<Employee>('employees');
    await box.add(employee);
    loadEmployees();
  }

  static Future<void> deleteEmployee(Employee employee) async {
    await employee.delete();
    loadEmployees();
  }

  static Future<void> insertEmployeeAt(Employee employee, int index) async {
    final box = Hive.box<Employee>('employees');
    final allEmployees = box.values.toList();

    allEmployees.insert(index, employee);

    await box.clear();
    await box.addAll(allEmployees);

    loadEmployees();
  }

  static Future<void> updateEmployee(Employee employee) async {
    await employee.save();
    loadEmployees();
  }
}
