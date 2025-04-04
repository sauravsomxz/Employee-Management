import 'package:flutter/material.dart';

int calculateCalendarRows(DateTime selectedDate) {
  DateTime firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 0);
  int startingWeekday = firstDayOfMonth.weekday % 7;
  int daysInMonth = DateUtils.getDaysInMonth(
    selectedDate.year,
    selectedDate.month,
  );
  int totalCells = startingWeekday + daysInMonth;
  return (totalCells / 7).ceil();
}

int daysUntilNext(int weekday) {
  DateTime now = DateTime.now();
  int daysUntil = (weekday - now.weekday + 7) % 7;
  return daysUntil == 0 ? 7 : daysUntil;
}
