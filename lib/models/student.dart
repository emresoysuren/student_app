import 'people.dart';

class Student extends People {
  Student(name, surname, age, gender) : super(name, surname, age, gender);

  Student.fromMap(Map<String, dynamic> m)
      : this(m["name"], m["surname"], m["age"],
            m["gender"] == "male" ? Gender.male : Gender.female);
}
