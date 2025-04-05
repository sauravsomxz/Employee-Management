import 'package:employee_management/core/constants/app_enums.dart';
import 'package:employee_management/core/utils/helper.dart';
import 'package:employee_management/core/widgets/calendar/quick_buttons.dart';
import 'package:employee_management/cubit/calendar/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickButtonsSection extends StatelessWidget {
  final DateTime? selectedDate;
  final CalendarType calendarType;

  const QuickButtonsSection({
    super.key,
    required this.selectedDate,
    required this.calendarType,
  });

  @override
  Widget build(BuildContext context) {
    if (calendarType == CalendarType.endDate) {
      return Row(
        children: [
          Expanded(
            child: QuickSelectButton(
              label: "No Date",
              daysToAdd: 0,
              selectedDate: selectedDate,
              isNoDate: true,
              onTap: (_) => context.read<CalendarCubit>().clearDate(),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: QuickSelectButton(
              label: "Today",
              daysToAdd: 0,
              selectedDate: selectedDate,
              onTap:
                  (days) => context.read<CalendarCubit>().selectQuickDate(days),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QuickSelectButton(
                  label: "Today",
                  daysToAdd: 0,
                  selectedDate: selectedDate,
                  onTap:
                      (days) =>
                          context.read<CalendarCubit>().selectQuickDate(days),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: QuickSelectButton(
                  label: "Next Mon",
                  daysToAdd: daysUntilNext(DateTime.monday),
                  selectedDate: selectedDate,
                  onTap:
                      (days) =>
                          context.read<CalendarCubit>().selectQuickDate(days),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: QuickSelectButton(
                  label: "Next Tue",
                  daysToAdd: daysUntilNext(DateTime.tuesday),
                  selectedDate: selectedDate,
                  onTap:
                      (days) =>
                          context.read<CalendarCubit>().selectQuickDate(days),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: QuickSelectButton(
                  label: "After 1 Week",
                  daysToAdd: 7,
                  selectedDate: selectedDate,
                  onTap:
                      (days) =>
                          context.read<CalendarCubit>().selectQuickDate(days),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
