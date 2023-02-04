abstract class People {
  String name;
  String surname;
  int yas;
  Gender gender;

  People(this.name, this.surname, this.yas, this.gender);

}

enum Gender {
  male,
  female,
}