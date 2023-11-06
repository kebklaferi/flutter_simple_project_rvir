import 'package:flutter/material.dart';
import 'package:flutter_project/hive-adapters/boxes.dart';
import 'package:flutter_project/hive-adapters/employee.dart';
import 'package:flutter_project/pages/first_page.dart';
import 'package:hive/hive.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Employee.employee.add("Name: $nameInputText Surname: $surnameInputText ");
    print(employeeBox.length);
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
                                    title: Text("${employee.name} ${employee.name}")
                                  ),
                              ),
                              ElevatedButton(
                                  onPressed: () => {},
                                  child: const Text("show")
                              ),
                            ],
                          );

                          /*
                          return ListTile(
                            title: Text(employee.name),
                          );

                           */
                        },
                      ),
                    )))
          ],
        ));
  }
}
