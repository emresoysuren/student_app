import 'package:flutter/material.dart';
import 'package:student_app/people.dart';
import 'package:student_app/repository/students_repository.dart';

class StudentsPage extends StatefulWidget {
  final StudentsRepository studentsRepository;

  const StudentsPage({super.key, required this.studentsRepository});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe7e5df),
      appBar: AppBar(
        title: const Text("Students Page"),
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
                  "${widget.studentsRepository.students.length} Students",
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: widget.studentsRepository.students.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) => StudentItem(
                student: widget.studentsRepository.students.elementAt(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentItem extends StatefulWidget {
  const StudentItem({
    Key? key,
    required this.student,
  }) : super(key: key);

  final Student student;

  @override
  State<StudentItem> createState() => _StudentItemState();
}

class _StudentItemState extends State<StudentItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${widget.student.name} ${widget.student.surname}"),
      leading: Icon(
        widget.student.gender == Gender.male ? Icons.male : Icons.female,
      ),
      trailing: IconButton(
        onPressed: () => setState(() {
          StudentsRepository.like(widget.student);
        }),
        icon: StudentsRepository.liked.contains(widget.student)
            ? const Icon(Icons.favorite_rounded, color: Color(0xffee4266))
            : const Icon(Icons.favorite_border_rounded),
      ),
    );
  }
}
