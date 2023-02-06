import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/models/people.dart';
import '../models/student.dart';

class StudentsRepository extends ChangeNotifier {
  final List<Student> students = [
    Student("James", "Bond", 99, Gender.male),
    Student("Dora", "The Explorer", 12, Gender.female),
  ];

  final liked = [];

  void like(student) {
    liked.contains(student) ? liked.remove(student) : liked.add(student);
    notifyListeners();
  }
}

final studentsProvider = ChangeNotifierProvider((ref) => StudentsRepository());
