import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee extends HiveObject{
  Employee({
    required this.name,
    required this.surname,
    required this.jobTitle,
    required this.dateOfBirth,
    required this.arrivalTime,
    required this.departureTime,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String surname;

  @HiveField(2)
  String jobTitle;

  @HiveField(3)
  DateTime dateOfBirth;

  @HiveField(4)
  DateTime arrivalTime;

  @HiveField(5)
  DateTime departureTime;
}