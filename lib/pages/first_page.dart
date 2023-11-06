import 'package:flutter/material.dart';
import 'package:flutter_project/hive-adapters/boxes.dart';
import 'package:flutter_project/hive-adapters/employee.dart';
import 'package:flutter_project/pages/second_page.dart';
import 'package:toastification/toastification.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _surnameTextController = TextEditingController();
  List<String> jobTitles = ["IT support", "Constructor", "Accountant"];
  String? dropDownValue = "IT support";
  DateTime dateOfBirth = DateTime.now();
  DateTime arrivalTime = DateTime.now();
  DateTime departureTime = DateTime.now();

  void showToastOnSuccess() {
    toastification.show(
        context: context,
        title: "Employee added successfully",
      autoCloseDuration: const Duration(seconds: 3)
    );
  }
  void showToastOnFailure() {
    toastification.show(
        context: context,
        title: "Ops, there was an error.",
      autoCloseDuration: const Duration(seconds: 3)
    );
  }

  void _addAnEmployee() {
    if(_nameTextController.text.isEmpty){
      showToastOnFailure();
    }
    else {
      employeeBox.put(
          "key_${employeeBox.length}",
          Employee(
              name: _nameTextController.text,
              surname: _surnameTextController.text,
              jobTitle: dropDownValue ?? "",
              dateOfBirth: dateOfBirth,
              arrivalTime: arrivalTime,
              departureTime: departureTime));
      showToastOnSuccess();
      _nameTextController.text = "";
      _surnameTextController.text = "";
    }
  }

  void _navigateToSecondPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SecondPage()));
  }

  void _changeDropDownValue(String? selectedValue) {
    setState(() {
      dropDownValue = selectedValue;
    });
  }

  void _selectArrivalTime() async {
    final selectedArrivalTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedArrivalTime != null) {
      setState(() {
        DateTime currentDate = DateTime.now();
        arrivalTime = DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
            selectedArrivalTime.hour,
            selectedArrivalTime.minute);
      });
    }
  }

  void _selectDepartureTime() async {
    final selectedDepartureTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedDepartureTime != null) {
      setState(() {
        DateTime currentDate = DateTime.now();
        departureTime = DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
            selectedDepartureTime.hour,
            selectedDepartureTime.minute);
      });
    }
  }

  void _handleDateOfBirth() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        dateOfBirth = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter project: first page"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Employee",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: _nameTextController,
                decoration: const InputDecoration(labelText: "name"),
              ),
              TextField(
                controller: _surnameTextController,
                decoration: const InputDecoration(labelText: "surname"),
              ),
              ElevatedButton(
                  onPressed: _handleDateOfBirth,
                  child: Text(
                      "Selected date of birth: ${dateOfBirth.year} - ${dateOfBirth.month} - ${dateOfBirth.day}")),
              DropdownButton(
                items: jobTitles.map((String jobTitle) {
                  return DropdownMenuItem<String>(
                    value: jobTitle,
                    child: Text(jobTitle),
                  );
                }).toList(),
                onChanged: _changeDropDownValue,
                value: dropDownValue,
              ),
              MaterialButton(
                onPressed: _selectArrivalTime,
                child: const Text(
                  "Select time of arrrival.",
                  style: TextStyle(backgroundColor: Colors.teal),
                ),
              ),
              Text(
                "Chosen time of arrival: ${"${arrivalTime.hour}:${arrivalTime.minute}"}",
              ),
              MaterialButton(
                onPressed: _selectDepartureTime,
                child: const Text(
                  "Select time of departure.",
                  style: TextStyle(backgroundColor: Colors.teal),
                ),
              ),
              Text(
                "Chosen time of departure: ${"${departureTime.hour}:${departureTime.minute}"}",
              ),
              TextButton(
                  onPressed: _addAnEmployee, child: const Text("Submit")),
              TextButton(
                  onPressed: _navigateToSecondPage,
                  child: const Text("Employee List")),
            ],
          ),
        ),
      ),
    );
  }
}
