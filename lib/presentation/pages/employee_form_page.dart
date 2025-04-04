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
import 'package:employee_management/presentation/widgets/role_selection_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmployeeFormPage extends StatelessWidget {
  const EmployeeFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.addEmployeeDetails,
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            CustomTextField(
              hintText: AppStrings.employeeNameHint,
              prefixIcon: Image.asset(ImagePaths.personHollowIcon),
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocProvider(
                            create: (_) => CalendarCubit(),
                            child: CustomCalendarDialog(
                              onDateSelected: (date) {
                                // use selected date
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: AbsorbPointer(
                      child: CustomTextField(
                        hintText:
                            context
                                        .watch<EmployeeFormCubit>()
                                        .state
                                        .startDate !=
                                    null
                                ? DateFormat('dd MMM, yyyy').format(
                                  context
                                      .watch<EmployeeFormCubit>()
                                      .state
                                      .startDate!,
                                )
                                : AppStrings.todayHint,
                        prefixIcon: Image.asset(ImagePaths.calendarHollowIcon),
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
                      showDialog(
                        context: context,
                        builder:
                            (_) => CustomCalendarDialog(
                              onDateSelected: (selectedDate) {
                                context.read<EmployeeFormCubit>().setEndDate(
                                  selectedDate,
                                );
                              },
                            ),
                      );
                    },
                    child: AbsorbPointer(
                      child: CustomTextField(
                        hintText:
                            context.watch<EmployeeFormCubit>().state.endDate !=
                                    null
                                ? DateFormat('dd MMM, yyyy').format(
                                  context
                                      .watch<EmployeeFormCubit>()
                                      .state
                                      .endDate!,
                                )
                                : AppStrings.noDateHint,
                        prefixIcon: Image.asset(ImagePaths.calendarHollowIcon),
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
          onPressed: () {},
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
