import 'package:flutter/material.dart';
import 'package:flutter_project/hive-adapters/employee.dart';
import 'package:flutter_project/pages/first_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive-adapters/boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  employeeBox = await Hive.openBox<Employee>('employeeBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}
