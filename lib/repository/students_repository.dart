import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/services/data_service.dart';
import '../models/student.dart';

class StudentsRepository extends ChangeNotifier {
  DataService dataService;

  StudentsRepository(this.dataService);

  List<Student> students = [];

  final liked = [];

  Future<void> reloadStudents() async {
    List<Student> cache = await dataService.studentDownloadAll();
    if (cache.length != students.length) {
      students = cache;
      notifyListeners();
    }
  }

  void like(student) {
    liked.contains(student) ? liked.remove(student) : liked.add(student);
    notifyListeners();
  }
}

final studentsProvider = ChangeNotifierProvider(
    (ref) => StudentsRepository(ref.watch(dataServiceProvider)));
