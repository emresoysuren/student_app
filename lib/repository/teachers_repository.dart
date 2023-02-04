import 'package:student_app/people.dart';

class TeachersRepository {
  final List<Teacher> teachers = [
    Teacher("Salvador", "Dali", 34, Gender.male),
    Teacher("Bruce", "Wayne", 21, Gender.male),
  ];

}

class Teacher extends People {
  Teacher(name, surname, yas, gender) : super(name, surname, yas, gender);
}
