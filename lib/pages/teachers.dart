import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/models/people.dart';
import 'package:student_app/repository/teachers_repository.dart';
import '../models/teacher.dart';
import 'teachers/teachers_add_teacher.dart';

class TeachersPage extends ConsumerWidget {
  const TeachersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TeachersRepository teachersRepository = ref.watch(teachersProvider);
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
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(36),
                      child: Text(
                        "${teachersRepository.teachers.length} Teachers",
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: TeacherDownloadButton(),
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.refresh(teachersListProvider);
              },
              child: ref.watch(teachersListProvider).when(
                    data: (data) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemBuilder: (BuildContext context, int index) =>
                          TeacherItem(
                        teacher: data.elementAt(index),
                      ),
                    ),
                    error: (error, stackTrace) => const SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Text("Error!")),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final isCreated = await Navigator.push<bool>(context,
              MaterialPageRoute(builder: (context) => const AddTeacher()));
          if (isCreated == true) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("A teacher is added.")));
          }
        },
      ),
    );
  }
}

class TeacherDownloadButton extends ConsumerStatefulWidget {
  const TeacherDownloadButton({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<TeacherDownloadButton> createState() =>
      _TeacherDownloadButtonState();
}

class _TeacherDownloadButtonState extends ConsumerState<TeacherDownloadButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : IconButton(
            icon: const Icon(Icons.download_rounded),
            onPressed: () async {
              try {
                setState(() {
                  isLoading = true;
                });
                await ref.read(teachersProvider).download();
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            },
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
