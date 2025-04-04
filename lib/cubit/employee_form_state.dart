import 'package:employee_management/core/constants/app_enums.dart';

class EmployeeFormState {
  final EmployeeRole? selectedRole;
  final DateTime? startDate;
  final DateTime? endDate;

  EmployeeFormState({this.selectedRole, this.startDate, this.endDate});

  factory EmployeeFormState.initial() {
    return EmployeeFormState(
      selectedRole: null,
      startDate: null,
      endDate: null,
    );
  }

  EmployeeFormState copyWith({
    EmployeeRole? selectedRole,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return EmployeeFormState(
      selectedRole: selectedRole ?? this.selectedRole,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
