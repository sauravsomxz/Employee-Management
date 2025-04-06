import 'package:employee_management/core/constants/app_enums.dart';
import 'package:employee_management/core/utils/helper.dart';
import 'package:employee_management/core/widgets/calendar/calendar_view.dart';
import 'package:employee_management/core/widgets/calendar/calendat_footer.dart';
import 'package:employee_management/core/widgets/calendar/month_header.dart';
import 'package:employee_management/core/widgets/calendar/quick_button_selector.dart';
import 'package:employee_management/cubit/calendar/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_platform/universal_platform.dart';

class CustomCalendarDialog extends StatelessWidget {
  final Function(DateTime?) onDateSelected;
  final CalendarType calendarType;

  const CustomCalendarDialog({
    super.key,
    required this.onDateSelected,
    required this.calendarType,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final state = context.watch<CalendarCubit>().state;
          final DateTime? selectedDate = state.selectedDate;
          final DateTime monthContext = selectedDate ?? DateTime.now();

          final screenHeight = constraints.maxHeight;
          final isLargeScreen = constraints.maxWidth > 500;

          // Set different heights depending on screen type
          final double dialogHeight =
              isLargeScreen
                  ? screenHeight * 0.98
                  : calculateCalendarRows(monthContext) > 5
                  ? screenHeight * 0.9
                  : screenHeight * 0.9;

          return Center(
            child: Container(
              width: isLargeScreen ? 500 : double.infinity,
              height:
                  UniversalPlatform.isWeb
                      ? dialogHeight
                      : (calculateCalendarRows(monthContext) > 5
                          ? MediaQuery.of(context).size.height * 0.7
                          : MediaQuery.of(context).size.height * 0.63),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  QuickButtonsSection(
                    selectedDate: selectedDate,
                    calendarType: calendarType,
                  ),
                  const SizedBox(height: 12),
                  MonthHeader(selectedDate: monthContext),
                  Expanded(
                    child: CalendarView(
                      selectedDate: selectedDate,
                      onDateTap:
                          (date) =>
                              context.read<CalendarCubit>().selectDate(date),
                      minDate: state.startDate,
                    ),
                  ),
                  const Divider(),
                  CalendarFooter(
                    selectedDate: selectedDate,
                    onDateSelected: onDateSelected,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
