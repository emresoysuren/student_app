import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/repository/messages_repository.dart';
import 'package:student_app/repository/students_repository.dart';
import 'package:student_app/repository/teachers_repository.dart';
import 'pages/students.dart';
import 'pages/messages.dart';
import 'pages/teachers.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ogrenci Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Home Page'),
    );
  }
}

class HomePage extends ConsumerWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StudentsRepository studentsRepository = ref.watch(studentsProvider);
    TeachersRepository teachersRepository = ref.watch(teachersProvider);
    MessagesRepository messagesRepository = ref.watch(messagesProvider);
    return Scaffold(
      backgroundColor: const Color(0xffe7e5df),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xff540d6e),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff540d6e),
              ),
              child: Text("Student Name"),
            ),
            ListTile(
              title: const Text("Students"),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StudentsPage(),
                ),
              ),
            ),
            ListTile(
              title: const Text("Teachers"),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TeachersPage(),
                ),
              ),
            ),
            ListTile(
              title: const Text("Messages"),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MessagesPage(),
                ),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: pi * 1.1,
              child: TextButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MessagesPage(),
                    ),
                  );
                },
                child: Text(
                  "${messagesRepository.notSeen} new messages",
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StudentsPage(),
                ),
              ),
              child: Text(
                "${studentsRepository.students.length} studens",
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TeachersPage(),
                ),
              ),
              child: Text(
                "${teachersRepository.teachers.length} teachers",
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
