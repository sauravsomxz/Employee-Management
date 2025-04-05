enum EmployeeRole { productDesigner, flutterDeveloper, qaTester, productOwner }

extension EmployeeRoleExtension on EmployeeRole {
  String get label {
    switch (this) {
      case EmployeeRole.productDesigner:
        return 'Product Designer';
      case EmployeeRole.flutterDeveloper:
        return 'Flutter Developer';
      case EmployeeRole.qaTester:
        return 'QA Tester';
      case EmployeeRole.productOwner:
        return 'Product Owner';
    }
  }
}

enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

extension WeekdayExtension on Weekday {
  String get label {
    switch (this) {
      case Weekday.monday:
        return 'Mon';
      case Weekday.tuesday:
        return 'Tue';
      case Weekday.wednesday:
        return 'Wed';
      case Weekday.thursday:
        return 'Thu';
      case Weekday.friday:
        return 'Fri';
      case Weekday.saturday:
        return 'Sat';
      case Weekday.sunday:
        return 'Sun';
    }
  }
}

enum CalendarType { startDate, endDate }
