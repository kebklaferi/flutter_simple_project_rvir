import 'package:flutter/material.dart';
import 'package:flutter_project/pages/employee.dart';

class SecondPage extends StatelessWidget {
  final String nameInputText;
  final String surnameInputText;
  final String jobTitle;
  final DateTime birthDate;
  final TimeOfDay timeOfArrival;
  final TimeOfDay timeOfDepart;


  const SecondPage({
    super.key,
    required this.nameInputText,
    required this.surnameInputText,
    required this.jobTitle,
    required this.birthDate,
    required this.timeOfArrival,
    required this.timeOfDepart,
  });

  @override
  Widget build(BuildContext context) {
    Employee.employee.add("Name: $nameInputText Surname: $surnameInputText ");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter project: second page"),
      ),
      body: ListView.builder(
        itemCount: Employee.employee.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Employee.employee[index]),
          );
        },
      ),
    );
  }
}
