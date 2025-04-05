import 'package:employee_management/core/constants/app_enums.dart';
import 'package:employee_management/core/utils/helper.dart';
import 'package:employee_management/core/widgets/calendar/calendar_view.dart';
import 'package:employee_management/core/widgets/calendar/calendat_footer.dart';
import 'package:employee_management/core/widgets/calendar/month_header.dart';
import 'package:employee_management/core/widgets/calendar/quick_button_selector.dart';
import 'package:employee_management/cubit/calendar/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (context, state) {
          final DateTime? selectedDate = state.selectedDate;

          // We'll use today to determine month layout and header even if selectedDate is null
          final DateTime monthContext = selectedDate ?? DateTime.now();

          return FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              height:
                  calculateCalendarRows(monthContext) > 5
                      ? MediaQuery.of(context).size.height * 0.7
                      : MediaQuery.of(context).size.height * 0.63,
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
                  CalendarView(
                    selectedDate:
                        selectedDate, // pass null to avoid highlighting
                    onDateTap:
                        (date) =>
                            context.read<CalendarCubit>().selectDate(date),
                  ),
                  const Divider(),
                  CalendarFooter(
                    selectedDate: selectedDate, // nullable supported here
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
