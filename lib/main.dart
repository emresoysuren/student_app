import 'package:flutter/material.dart';
import 'package:student_app/repository/messages_repository.dart';
import 'package:student_app/repository/students_repository.dart';
import 'package:student_app/repository/teachers_repository.dart';
import 'pages/students.dart';
import 'pages/messages.dart';
import 'pages/teachers.dart';

void main() {
  runApp(const App());
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

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MessagesRepository messagesRepository = MessagesRepository();
  final TeachersRepository teachersRepository = TeachersRepository();
  final StudentsRepository studentsRepository = StudentsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe7e5df),
      appBar: AppBar(
        title: Text(widget.title),
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
                  builder: (context) => StudentsPage(
                    studentsRepository: studentsRepository,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text("Teachers"),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TeachersPage(
                    teachersRepository: teachersRepository,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text("Messages"),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MessagesPage(
                    messagesRepository: messagesRepository,
                  ),
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
            TextButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MessagesPage(
                      messagesRepository: messagesRepository,
                    ),
                  ),
                );
                setState(() {});
              },
              child: Text(
                "${MessagesRepository.notSeen} new messages",
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StudentsPage(
                    studentsRepository: studentsRepository,
                  ),
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
                  builder: (context) => TeachersPage(
                    teachersRepository: teachersRepository,
                  ),
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
