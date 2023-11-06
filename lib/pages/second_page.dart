import 'package:flutter/material.dart';
import 'package:flutter_project/hive-adapters/boxes.dart';
import 'package:flutter_project/hive-adapters/employee.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _surnameTextController = TextEditingController();
  List<String> jobTitles = ["IT support", "Constructor", "Accountant"];
  String? dropDownValue = "IT support";
  DateTime dateOfBirth = DateTime.now();
  DateTime arrivalTime = DateTime.now();
  DateTime departureTime = DateTime.now();

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
  void _changeDropDownValue(String? selectedValue) {
    setState(() {
      dropDownValue = selectedValue;
    });
  }
  void deleteEmployee(Employee currentEmployee){
    employeeBox.delete(currentEmployee.key);
    setState(() {});
    Navigator.of(context).pop();
  }
  void setEmployeeToEdit(Employee currentEmployee){
    _nameTextController.text = currentEmployee.name;
    _surnameTextController.text = currentEmployee.surname;
    dropDownValue = currentEmployee.jobTitle;
    dateOfBirth = currentEmployee.dateOfBirth;
    arrivalTime = currentEmployee.arrivalTime;
    departureTime = currentEmployee.departureTime;
    editEmployeeDialog(currentEmployee);
  }

  void updateEmployee (Employee currentEmployee) {
    employeeBox.put(currentEmployee.key, Employee(
        name: _nameTextController.text,
        surname: _surnameTextController.text,
        jobTitle: dropDownValue ?? "",
        dateOfBirth: dateOfBirth,
        arrivalTime: arrivalTime,
        departureTime: departureTime));
    Navigator.of(context).pop();
    setState(() {});
  }

  Future editEmployeeDialog(Employee currentEmployee) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit an Employee: "),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")
                ),
                ElevatedButton(
                    onPressed: () => updateEmployee(currentEmployee)
                    ,
                    child: const Text("Submit")
                )
              ],
            )
          ],
        ),
      ));
  
  Future openEmployeeDialog(Employee currentEmployee) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Employee information:"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Name and Surname: ${currentEmployee.name} ${currentEmployee.surname}",
                  textAlign: TextAlign.left),
              Text("Job Title: ${currentEmployee.jobTitle}",
                  textAlign: TextAlign.left),
              Text("Date of Birth: ${currentEmployee.dateOfBirth}",
                  textAlign: TextAlign.left),
              Text("Time of Arrival: ${currentEmployee.arrivalTime}",
                  textAlign: TextAlign.left),
              Text("Time of Departure: ${currentEmployee.departureTime}",
                  textAlign: TextAlign.left),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                  onPressed: () => {
                    setEmployeeToEdit(currentEmployee)
                  },
                  child: const Text("edit"),
                ),
                ElevatedButton(
                  onPressed: () => deleteEmployee(currentEmployee),
                  child: const Text("delete"),
                ),
              ])
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter project: second page"),
        ),
        body: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        itemCount: employeeBox.length,
                        itemBuilder: (context, index) {
                          Employee employee = employeeBox.getAt(index);
                          return Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                    title: Text(
                                        "${employee.name} ${employee.surname}")),
                              ),
                              ElevatedButton(
                                  onPressed: () => openEmployeeDialog(employee),
                                  child: const Text("show")),
                            ],
                          );
                        },
                      ),
                    )))
          ],
        ));
  }
}
