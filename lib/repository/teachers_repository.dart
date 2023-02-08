import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/models/people.dart';
import 'package:student_app/services/data_service.dart';
import '../models/teacher.dart';

class TeachersRepository extends ChangeNotifier {
  final DataService dataService;

  TeachersRepository(this.dataService);

  final List<Teacher> teachers = [
    Teacher("Salvador", "Dali", 34, Gender.male),
    Teacher("Bruce", "Wayne", 21, Gender.male),
  ];

  Future<void> download() async {
    final Teacher downloaded = await dataService.teacherDownload();

    teachers.add(downloaded);
    notifyListeners();
  }

  Future<void> uploadTeacher(Teacher teacher) async {
    await dataService.uploadTeacher(teacher);
    teachers.add(teacher);
    notifyListeners();
  }
}

final teachersProvider = ChangeNotifierProvider(
  (ref) => TeachersRepository(ref.watch(dataServiceProvider)),
);
