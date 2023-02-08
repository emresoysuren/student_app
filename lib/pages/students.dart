import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/models/people.dart';
import 'package:student_app/repository/students_repository.dart';

class StudentsPage extends ConsumerStatefulWidget {
  const StudentsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudentsPageState();
}

class _StudentsPageState extends ConsumerState {
  var _isReloading;

  @override
  void initState() {
    _isReloading = Future.delayed(Duration.zero)
        .then((_) => ref.read(studentsProvider).reloadStudents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: FutureBuilder(
              future: _isReloading,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasError != true) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: studentsRepository.students.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (BuildContext context, int index) =>
                        StudentItem(index: index),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StudentItem extends ConsumerWidget {
  final int index;

  StudentItem({Key? key, required this.index})
      : super(key: key ?? Key(index.toString()));

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
