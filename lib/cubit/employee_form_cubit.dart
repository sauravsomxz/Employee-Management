import 'package:employee_management/core/constants/app_enums.dart';
import 'package:employee_management/cubit/employee_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeFormCubit extends Cubit<EmployeeFormState> {
  EmployeeFormCubit() : super(EmployeeFormState.initial());

  void setRole(EmployeeRole role) {
    emit(state.copyWith(selectedRole: role));
  }
}
