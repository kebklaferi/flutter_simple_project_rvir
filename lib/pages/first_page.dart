import 'package:flutter/material.dart';
import 'package:flutter_project/pages/second_page.dart';

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
  TimeOfDay arrivalTime = TimeOfDay.now();
  TimeOfDay departureTime = TimeOfDay.now();

  void _navigateToSecondPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SecondPage(
                  nameInputText: _nameTextController.text,
                  surnameInputText: _surnameTextController.text,
                  jobTitle: dropDownValue ?? "",
                  birthDate: dateOfBirth,
                  timeOfArrival: arrivalTime,
                  //uredi
                  timeOfDepart: departureTime, //uredi
                )));
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
        arrivalTime = selectedArrivalTime;
      });
    }
  }void _selectDepartureTime() async {
    final selectedDepartureTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
    );
    if (selectedDepartureTime != null) {
      setState(() {
        departureTime = selectedDepartureTime;
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
                  style: TextStyle(
                      backgroundColor: Colors.teal
                  ),
                ),
              ),
              Text(
                  "Chosen time of arrival: ${arrivalTime.format(context).toString()}",
              ),
              MaterialButton(
                onPressed: _selectDepartureTime,
                child: const Text(
                  "Select time of departure.",
                  style: TextStyle(
                      backgroundColor: Colors.teal
                  ),
                ),
              ),
              Text(
                "Chosen time of departure: ${departureTime.format(context).toString()}",
              ),
              TextButton(
                  onPressed: _navigateToSecondPage,
                  child: const Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
