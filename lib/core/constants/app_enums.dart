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
