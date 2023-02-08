abstract class People {
  String name;
  String surname;
  int age;
  Gender gender;

  People(this.name, this.surname, this.age, this.gender);
}

enum Gender {
  male,
  female,
}
