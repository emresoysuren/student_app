import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/people.dart';
import 'package:student_app/repository/students_repository.dart';

class MessagesRepository extends ChangeNotifier {
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

  int notSeen = 4;

  void clearMessages() {
    notSeen = 0;
    notifyListeners();
  }

  void newMessage(Message message) {
    messages.add(message);
    notSeen += 1;
    notifyListeners();
  }
}

final messagesProvider = ChangeNotifierProvider((ref) => MessagesRepository());

class Message {
  String text;
  People sender;
  DateTime time;

  Message(this.text, this.sender, this.time);
}
