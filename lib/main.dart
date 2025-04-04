import 'package:flutter/material.dart';
import 'presentation/pages/employee_list_page.dart';

void main() {
  runApp(const EmployeeApp());
}

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Manager',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const EmployeeListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
