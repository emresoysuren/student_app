import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/models/student.dart';
import 'package:student_app/models/teacher.dart';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl = "/* baseUrl */";

  Future<List<Student>> studentDownloadAll() async {
    final response = await http.get(Uri.parse("$baseUrl/students"));
    List<dynamic> list = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<Student> result = [];
      for (Map<String, dynamic> m in list) {
        result.add(Student.fromMap(m));
      }
      return result;
    } else {
      throw Exception('Failed to download students! ${response.statusCode}');
    }
  }

  // #TeacherAPI

  Future<Teacher> teacherDownload() async {
    final response =
        await http.get(Uri.parse("$baseUrl/teachers/${Random().nextInt(50)}"));

    if (response.statusCode == 200) {
      return Teacher.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to download teachers! ${response.statusCode}');
    }
  }

  Future<void> uploadTeacher(Teacher teacher) async {
    final response = await http.post(
      Uri.parse("$baseUrl/teachers"),
      headers: <String, String>{
        "Contect-Type": "apploication/json; chatset=UTF-8",
      },
      body: jsonEncode(teacher.toMap()),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to upload teachers! ${response.statusCode}');
    }
  }
}

final dataServiceProvider = Provider((ref) => DataService());
