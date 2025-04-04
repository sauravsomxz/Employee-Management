import 'package:employee_management/core/assets/local_assets.dart';
import 'package:employee_management/core/constants/app_colors.dart';
import 'package:employee_management/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendarDialog extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CustomCalendarDialog({super.key, required this.onDateSelected});

  @override
  State<CustomCalendarDialog> createState() => _CustomCalendarDialogState();
}

class _CustomCalendarDialogState extends State<CustomCalendarDialog> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  void _selectQuickDate(int daysToAdd) {
    setState(() {
      DateTime targetDate = DateTime.now().add(Duration(days: daysToAdd));
      selectedDate = DateTime(
        targetDate.year,
        targetDate.month,
        targetDate.day,
      );
    });
  }

  void _changeMonth(int offset) {
    setState(() {
      int newMonth = selectedDate.month + offset;
      int newYear = selectedDate.year;

      if (newMonth > 12) {
        newMonth = 1;
        newYear++;
      } else if (newMonth < 1) {
        newMonth = 12;
        newYear--;
      }

      int daysInNewMonth = DateUtils.getDaysInMonth(newYear, newMonth);
      int newDay = selectedDate.day <= daysInNewMonth ? selectedDate.day : 1;

      selectedDate = DateTime(newYear, newMonth, newDay);
    });
  }

  int _calculateCalendarRows() {
    DateTime firstDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month,
      0,
    );
    int startingWeekday = firstDayOfMonth.weekday % 7;
    int daysInMonth = DateUtils.getDaysInMonth(
      selectedDate.year,
      selectedDate.month,
    );
    int totalCells = startingWeekday + daysInMonth;
    return (totalCells / 7).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(16),
          height:
              _calculateCalendarRows() > 5
                  ? MediaQuery.of(context).size.height * 0.7
                  : MediaQuery.of(context).size.height * 0.63,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              // Quick Select Buttons
              Row(
                children: [
                  Expanded(child: _quickSelectButton("Today", 0)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _quickSelectButton(
                      "Next Mon",
                      _daysUntilNext(DateTime.monday),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _quickSelectButton(
                      "Next Tue",
                      _daysUntilNext(DateTime.tuesday),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: _quickSelectButton("After 1 Week", 7)),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => _changeMonth(-1),
                    icon: Image.asset(
                      ImagePaths.calendarArrowLeft,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  Text(
                    DateFormat('MMMM yyyy').format(selectedDate),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.textColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _changeMonth(1),
                    icon: Image.asset(
                      ImagePaths.calendarArrowRight,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ],
              ),

              // Calendar Grid
              _buildCalendar(),

              const Divider(),

              // Selected Date & Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        ImagePaths.calendarHollowIcon,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 2),
                      Text(
                        DateFormat('dd MMM yyyy').format(selectedDate),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.cancelButtonBg,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          AppStrings.cancel,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickSelectButton(String label, int daysToAdd) {
    DateTime targetDate = DateTime.now().add(Duration(days: daysToAdd));
    targetDate = DateTime(targetDate.year, targetDate.month, targetDate.day);
    bool isSelected =
        selectedDate.year == targetDate.year &&
        selectedDate.month == targetDate.month &&
        selectedDate.day == targetDate.day;

    return TextButton(
      onPressed: () => _selectQuickDate(daysToAdd),
      style: TextButton.styleFrom(
        backgroundColor:
            isSelected ? AppColors.primary : AppColors.cancelButtonBg,
        foregroundColor: isSelected ? Colors.white : AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
    );
  }

  Widget _buildCalendar() {
    DateTime firstDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month,
      0,
    );
    int startingWeekday = firstDayOfMonth.weekday % 7; // Monday-based index
    List<Widget> calendarDays = [];

    // Empty cells before the first day of the month
    for (int i = 0; i < startingWeekday; i++) {
      calendarDays.add(const SizedBox()); // Empty placeholders
    }

    // Dates of the month
    int daysInMonth = DateUtils.getDaysInMonth(
      selectedDate.year,
      selectedDate.month,
    );
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        day,
      );
      bool isToday =
          currentDate.year == DateTime.now().year &&
          currentDate.month == DateTime.now().month &&
          currentDate.day == DateTime.now().day;

      bool isSelected =
          currentDate.year == selectedDate.year &&
          currentDate.month == selectedDate.month &&
          currentDate.day == selectedDate.day;

      calendarDays.add(
        GestureDetector(
          onTap: () => setState(() => selectedDate = currentDate),
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
                color: isSelected ? AppColors.white : AppColors.textColor,
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
        // Weekday labels (added once)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                  .map(
                    (day) => Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          day,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
        // Calendar grid with dates
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

int _daysUntilNext(int weekday) {
  DateTime now = DateTime.now();
  int daysUntil = (weekday - now.weekday + 7) % 7;
  return daysUntil == 0 ? 7 : daysUntil;
}
