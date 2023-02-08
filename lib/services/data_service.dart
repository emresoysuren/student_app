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
    final List<dynamic> list = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return list.map<Student>((e) => Student.fromMap(e)).toList();
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
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(teacher.toMap()),
    );
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to upload teachers! ${response.statusCode}');
    }
  }

  Future<List<Teacher>> teacherDownloadAll() async {
    final response = await http.get(Uri.parse("$baseUrl/teachers"));
    final List<dynamic> list = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return list.map<Teacher>((e) => Teacher.fromMap(e)).toList();
    } else {
      throw Exception('Failed to download students! ${response.statusCode}');
    }
  }
}

final dataServiceProvider = Provider((ref) => DataService());
