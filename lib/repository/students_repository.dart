import 'package:student_app/people.dart';

class StudentsRepository {
  final List<Student> students = [
    Student("James", "Bond", 99, Gender.male),
    Student("Dora", "The Explorer", 12, Gender.female),
  ];

  static final liked = [];

  static void like(student) {
    liked.contains(student) ? liked.remove(student) : liked.add(student);
  }
}

class Student extends People {
  Student(name, surname, yas, gender) : super(name, surname, yas, gender);
}
