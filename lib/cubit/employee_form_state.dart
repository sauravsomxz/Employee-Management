import 'package:employee_management/core/constants/app_enums.dart';

class EmployeeFormState {
  final EmployeeRole? selectedRole;

  EmployeeFormState({this.selectedRole});

  factory EmployeeFormState.initial() {
    return EmployeeFormState(selectedRole: null);
  }

  EmployeeFormState copyWith({EmployeeRole? selectedRole}) {
    return EmployeeFormState(selectedRole: selectedRole ?? this.selectedRole);
  }
}
