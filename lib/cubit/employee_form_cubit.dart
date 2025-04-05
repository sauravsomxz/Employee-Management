import 'package:employee_management/core/constants/app_enums.dart';
import 'package:employee_management/cubit/employee_form_state.dart';
import 'package:employee_management/data/models/employee_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeFormCubit extends Cubit<EmployeeFormState> {
  EmployeeFormCubit({Employee? initialEmployee})
    : super(
        initialEmployee != null
            ? EmployeeFormState(
              name: initialEmployee.name,
              selectedRole: initialEmployee.role,
              startDate: initialEmployee.startDate,
              endDate: initialEmployee.endDate,
            )
            : EmployeeFormState.initial(),
      );

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setRole(EmployeeRole role) {
    emit(state.copyWith(selectedRole: role));
  }

  void setStartDate(DateTime date) {
    emit(state.copyWith(startDate: date));
  }

  void setEndDate(DateTime? date) {
    emit(state.copyWith(endDate: date));
  }
}
