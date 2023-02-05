import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/people.dart';

class TeachersRepository extends ChangeNotifier {
  final List<Teacher> teachers = [
    Teacher("Salvador", "Dali", 34, Gender.male),
    Teacher("Bruce", "Wayne", 21, Gender.male),
  ];
}

final teachersProvider = ChangeNotifierProvider((ref) => TeachersRepository());

class Teacher extends People {
  Teacher(name, surname, yas, gender) : super(name, surname, yas, gender);
}
