import 'package:employee_management/core/constants/app_enums.dart';

class EmployeeFormState {
  final String? name;
  final EmployeeRole? selectedRole;
  final DateTime? startDate;
  final DateTime? endDate;

  EmployeeFormState({
    required this.name,
    this.selectedRole,
    this.startDate,
    this.endDate,
  });

  factory EmployeeFormState.initial() {
    return EmployeeFormState(
      name: null,
      selectedRole: null,
      startDate: null,
      endDate: null,
    );
  }

  EmployeeFormState copyWith({
    String? name,
    EmployeeRole? selectedRole,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return EmployeeFormState(
      name: name ?? this.name,
      selectedRole: selectedRole ?? this.selectedRole,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
