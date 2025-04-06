import 'package:employee_management/core/assets/local_assets.dart';
import 'package:employee_management/core/constants/app_colors.dart';
import 'package:employee_management/core/constants/app_enums.dart';
import 'package:employee_management/core/constants/app_strings.dart';
import 'package:employee_management/core/widgets/custom_calendar_widget.dart';
import 'package:employee_management/core/widgets/custom_drop_down_field.dart';
import 'package:employee_management/core/widgets/custom_text_field.dart';
import 'package:employee_management/cubit/calendar/calendar_cubit.dart';
import 'package:employee_management/cubit/employee_form_cubit.dart';
import 'package:employee_management/cubit/employee_form_state.dart';
import 'package:employee_management/data/models/employee_model.dart';
import 'package:employee_management/presentation/widgets/role_selection_bottom_sheet.dart';
import 'package:employee_management/repository/employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmployeeFormPage extends StatefulWidget {
  final Employee? employeeToEdit;

  const EmployeeFormPage({super.key, this.employeeToEdit});

  @override
  State<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  late final EmployeeFormCubit _cubit;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<EmployeeFormCubit>();

    if (widget.employeeToEdit != null) {
      final employee = widget.employeeToEdit!;
      _cubit.setName(employee.name);
      nameController.text = employee.name;
      _cubit.setRole(employee.role);
      _cubit.setStartDate(employee.startDate);
      if (employee.endDate != null) {
        _cubit.setEndDate(employee.endDate!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.employeeToEdit != null
              ? AppStrings.editEmployeeDetails
              : AppStrings.addEmployeeDetails,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.white),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          if (widget.employeeToEdit != null)
            GestureDetector(
              onTap: () {
                EmployeeRepository.deleteEmployee(widget.employeeToEdit!);
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Image.asset(
                  ImagePaths.deleteIcon,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              CustomTextField(
                hintText: AppStrings.employeeNameHint,
                prefixIcon: Image.asset(ImagePaths.personHollowIcon),
                controller: nameController,
                onChanged: (value) {
                  context.read<EmployeeFormCubit>().setName(value);
                },
              ),
              const SizedBox(height: 18),

              // Role Selection Dropdown using Cubit & Bottom Sheet
              BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
                builder: (context, selectedRole) {
                  final cubit = context.read<EmployeeFormCubit>();
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder:
                            (_) => BlocProvider.value(
                              value: cubit,
                              child: Container(
                                margin: const EdgeInsets.only(top: 80),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: const RoleBottomSheet(
                                  roles: EmployeeRole.values,
                                ),
                              ),
                            ),
                      );
                    },
                    child: AbsorbPointer(
                      child: CustomDropdownField<EmployeeRole>(
                        hintText: AppStrings.selectRoleHint,
                        value: selectedRole.selectedRole,
                        items:
                            EmployeeRole.values.map((role) {
                              return DropdownMenuItem<EmployeeRole>(
                                value: role,
                                child: Text(role.label),
                              );
                            }).toList(),
                        onChanged: (_) {},
                        prefixIcon: Image.asset(ImagePaths.briefcaseHollowIcon),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 18),
              // Date Range Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final cubit = context.read<EmployeeFormCubit>();

                        showDialog(
                          context: context,
                          builder:
                              (_) => BlocProvider(
                                create: (_) => CalendarCubit(),
                                child: CustomCalendarDialog(
                                  onDateSelected: (date) {
                                    cubit.setStartDate(date!);
                                  },
                                  calendarType: CalendarType.startDate,
                                ),
                              ),
                        );
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: () {
                            final startDate =
                                context
                                    .watch<EmployeeFormCubit>()
                                    .state
                                    .startDate;
                            if (startDate == null) return AppStrings.todayHint;

                            final now = DateTime.now();
                            final isToday =
                                startDate.year == now.year &&
                                startDate.month == now.month &&
                                startDate.day == now.day;

                            return isToday
                                ? 'Today'
                                : DateFormat('dd MMM yyyy').format(startDate);
                          }(),
                          prefixIcon: Image.asset(
                            ImagePaths.calendarHollowIcon,
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Image.asset(ImagePaths.arrowRightIcon, height: 20, width: 20),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final cubit = context.read<EmployeeFormCubit>();

                        showDialog(
                          context: context,
                          builder:
                              (_) => BlocProvider(
                                create:
                                    (_) => CalendarCubit(
                                      startDate: cubit.state.startDate,
                                    ),
                                child: CustomCalendarDialog(
                                  onDateSelected: (selectedDate) {
                                    cubit.setEndDate(selectedDate);
                                  },
                                  calendarType: CalendarType.endDate,
                                ),
                              ),
                        );
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText:
                              context
                                          .watch<EmployeeFormCubit>()
                                          .state
                                          .endDate !=
                                      null
                                  ? DateFormat('dd MMM, yyyy').format(
                                    context
                                        .watch<EmployeeFormCubit>()
                                        .state
                                        .endDate!,
                                  )
                                  : AppStrings.noDateHint,
                          prefixIcon: Image.asset(
                            ImagePaths.calendarHollowIcon,
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            backgroundColor: AppColors.cancelButtonBg,
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text(
            AppStrings.cancel,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final cubit = context.read<EmployeeFormCubit>();
            final state = cubit.state;

            final name = state.name;
            final role = state.selectedRole;
            final startDate = state.startDate;
            final endDate = state.endDate;

            if (name != null &&
                name.isNotEmpty &&
                role != null &&
                startDate != null) {
              if (widget.employeeToEdit != null) {
                widget.employeeToEdit!
                  ..name = name
                  ..role = role
                  ..startDate = startDate
                  ..endDate = endDate;

                EmployeeRepository.updateEmployee(widget.employeeToEdit!);
              } else {
                // Adding new employee
                final newEmployee = Employee(
                  name: name,
                  role: role,
                  startDate: startDate,
                  endDate: endDate,
                );
                EmployeeRepository.addEmployee(newEmployee);
              }

              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppStrings.pleaseFillAllRequiredFields),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text(
            AppStrings.save,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
