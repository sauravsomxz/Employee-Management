import 'package:employee_management/core/constants/app_colors.dart';
import 'package:employee_management/core/constants/app_enums.dart';
import 'package:employee_management/data/models/employee_model.dart';
import 'package:employee_management/repository/employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';
import 'presentation/pages/employee_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive init for web vs other platforms
  if (!UniversalPlatform.isWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  } else {
    await Hive.initFlutter(); // Hive handles web initialization internally
  }

  Hive.registerAdapter(EmployeeAdapter());
  Hive.registerAdapter(EmployeeRoleAdapter());

  await Hive.openBox<Employee>('employees');
  EmployeeRepository.loadEmployees();

  runApp(const EmployeeApp());
}

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,
          selectionColor: AppColors.textSelectionColor,
          selectionHandleColor: AppColors.primary,
        ),
      ),
      home: const EmployeeListPage(),
    );
  }
}
