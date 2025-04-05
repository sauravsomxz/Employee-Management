import 'package:employee_management/data/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class EmployeeRepository {
  static final Box<Employee> _employeeBox = Hive.box<Employee>('employees');

  static ValueNotifier<List<Employee>> currentEmployees = ValueNotifier([]);
  static ValueNotifier<List<Employee>> previousEmployees = ValueNotifier([]);

  static void loadEmployees() {
    final all = _employeeBox.values.toList();
    currentEmployees.value = all.where((e) => e.isCurrent).toList();
    previousEmployees.value = all.where((e) => !e.isCurrent).toList();
  }

  static void addEmployee(Employee employee) {
    _employeeBox.add(employee);
    loadEmployees();
  }
}
