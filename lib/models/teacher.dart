import 'people.dart';

class Teacher extends People {
  Teacher(name, surname, age, gender) : super(name, surname, age, gender);

  Teacher.fromMap(Map<String, dynamic> m)
      : this(m["name"], m["surname"], m["age"],
            m["gender"] == "male" ? Gender.male : Gender.female);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "surname": surname,
      "age": age,
      "gender": gender == Gender.male ? "male" : "female",
    };
  }
}
