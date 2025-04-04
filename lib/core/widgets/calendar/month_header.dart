import 'package:employee_management/cubit/calendar/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MonthHeader extends StatelessWidget {
  final DateTime selectedDate;

  const MonthHeader({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => context.read<CalendarCubit>().changeMonth(-1),
          icon: const Icon(Icons.arrow_left),
        ),
        Text(
          DateFormat('MMMM yyyy').format(selectedDate),
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        IconButton(
          onPressed: () => context.read<CalendarCubit>().changeMonth(1),
          icon: const Icon(Icons.arrow_right),
        ),
      ],
    );
  }
}
