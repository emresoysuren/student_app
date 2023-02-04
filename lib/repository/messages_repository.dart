import 'package:student_app/people.dart';
import 'package:student_app/repository/students_repository.dart';

class MessagesRepository {
  final List<Message> messages = [
    Message(
      "Hello!",
      StudentsRepository().students[0],
      DateTime.now().subtract(
        const Duration(minutes: 3),
      ),
    ),
    Message(
      "How are you?",
      StudentsRepository().students[0],
      DateTime.now().subtract(
        const Duration(minutes: 3),
      ),
    ),
    Message(
      "Oh, hi!",
      StudentsRepository().students[1],
      DateTime.now().subtract(
        const Duration(minutes: 3),
      ),
    ),
    Message(
      "I'm fine.",
      StudentsRepository().students[1],
      DateTime.now().subtract(
        const Duration(minutes: 3),
      ),
    ),
  ];

  static int notSeen = 4;
}

class Message {
  String text;
  People sender;
  DateTime time;

  Message(this.text, this.sender, this.time);
}
