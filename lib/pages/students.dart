import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/people.dart';
import 'package:student_app/repository/students_repository.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StudentsRepository studentsRepository = ref.watch(studentsProvider);
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
                  "${studentsRepository.students.length} Students",
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: studentsRepository.students.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) =>
                  StudentItem(index: index),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentItem extends ConsumerWidget {
  final int index;

  const StudentItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StudentsRepository studentsRepository = ref.watch(studentsProvider);
    return ListTile(
      title: Text(
          "${studentsRepository.students[index].name} ${studentsRepository.students[index].surname}"),
      leading: Icon(
        studentsRepository.students[index].gender == Gender.male
            ? Icons.male
            : Icons.female,
      ),
      trailing: IconButton(
        onPressed: () =>
            ref.read(studentsProvider).like(studentsRepository.students[index]),
        icon: studentsRepository.liked
                .contains(studentsRepository.students[index])
            ? const Icon(Icons.favorite_rounded, color: Color(0xffee4266))
            : const Icon(Icons.favorite_border_rounded),
      ),
    );
  }
}
