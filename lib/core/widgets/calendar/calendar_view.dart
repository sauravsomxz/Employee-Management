import 'package:employee_management/core/constants/app_enums.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateTap;

  const CalendarView({
    super.key,
    required this.selectedDate,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    // Fallback to current date to render the month's structure only
    final DateTime displayMonth = selectedDate ?? DateTime.now();

    DateTime firstDayOfMonth = DateTime(
      displayMonth.year,
      displayMonth.month,
      1,
    );
    int startingWeekday = firstDayOfMonth.weekday % 7;

    List<Widget> calendarDays = [];

    // Add blank placeholders for days before the first
    for (int i = 0; i < startingWeekday; i++) {
      calendarDays.add(const SizedBox());
    }

    int daysInMonth = DateUtils.getDaysInMonth(
      displayMonth.year,
      displayMonth.month,
    );

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDate = DateTime(
        displayMonth.year,
        displayMonth.month,
        day,
      );

      bool isToday =
          DateTime.now().year == currentDate.year &&
          DateTime.now().month == currentDate.month &&
          DateTime.now().day == currentDate.day;

      bool isSelected =
          selectedDate != null &&
          currentDate.year == selectedDate!.year &&
          currentDate.month == selectedDate!.month &&
          currentDate.day == selectedDate!.day;

      calendarDays.add(
        GestureDetector(
          onTap: () => onDateTap(currentDate),
          child: Container(
            margin: const EdgeInsets.all(4),
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              shape: BoxShape.circle,
              border:
                  isToday && !isSelected
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
            ),
            child: Text(
              "$day",
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              Weekday.values
                  .map(
                    (weekday) => Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          weekday.label,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          physics: const NeverScrollableScrollPhysics(),
          children: calendarDays,
        ),
      ],
    );
  }
}
