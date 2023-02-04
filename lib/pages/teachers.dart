import 'package:flutter/material.dart';
import 'package:student_app/people.dart';
import 'package:student_app/repository/teachers_repository.dart';

class TeachersPage extends StatefulWidget {
  final TeachersRepository teachersRepository;

  const TeachersPage({super.key, required this.teachersRepository});

  @override
  State<TeachersPage> createState() => TeachersPageState();
}

class TeachersPageState extends State<TeachersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe7e5df),
      appBar: AppBar(
        title: const Text("Teachers Page"),
        backgroundColor: const Color(0xff540d6e),
      ),
      body: Column(
        children: [
          PhysicalModel(
            color: const Color(0xffe7e5df),
            elevation: 8,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Text(
                  "${widget.teachersRepository.teachers.length} Teachers",
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: widget.teachersRepository.teachers.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) => TeacherItem(
                teacher: widget.teachersRepository.teachers.elementAt(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherItem extends StatelessWidget {
  const TeacherItem({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${teacher.name} ${teacher.surname}"),
      leading: Icon(
        teacher.gender == Gender.male ? Icons.male : Icons.female,
      ),
    );
  }
}
