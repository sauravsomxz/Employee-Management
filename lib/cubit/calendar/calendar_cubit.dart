import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarState {
  final DateTime? selectedDate;
  final DateTime? startDate;

  CalendarState({required this.selectedDate, required this.startDate});

  CalendarState copyWith({DateTime? selectedDate, DateTime? startDate}) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      startDate: startDate ?? this.startDate,
    );
  }
}

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({DateTime? startDate})
    : super(CalendarState(selectedDate: DateTime.now(), startDate: startDate));

  void setStartDate(DateTime date) {
    emit(state.copyWith(startDate: date));
  }

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void selectQuickDate(int daysToAdd) {
    final target = DateTime.now().add(Duration(days: daysToAdd));
    emit(
      state.copyWith(
        selectedDate: DateTime(target.year, target.month, target.day),
      ),
    );
  }

  void clearDate() {
    emit(state.copyWith(selectedDate: null));
  }

  void changeMonth(int offset) {
    if (state.selectedDate == null) return;

    int newMonth = state.selectedDate!.month + offset;
    int newYear = state.selectedDate!.year;

    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    } else if (newMonth < 1) {
      newMonth = 12;
      newYear--;
    }

    int daysInNewMonth = DateUtils.getDaysInMonth(newYear, newMonth);
    int newDay =
        state.selectedDate!.day <= daysInNewMonth ? state.selectedDate!.day : 1;

    emit(state.copyWith(selectedDate: DateTime(newYear, newMonth, newDay)));
  }
}
