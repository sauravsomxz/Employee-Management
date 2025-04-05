import 'package:employee_management/core/constants/app_enums.dart';
import 'package:hive/hive.dart';
part 'employee_model.g.dart';

@HiveType(typeId: 0)
class Employee extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  EmployeeRole role;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  DateTime? endDate;

  Employee({
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
  });

  bool get isCurrent => endDate == null || endDate!.isAfter(DateTime.now());
}
