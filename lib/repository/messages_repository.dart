import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message.dart';
import '../models/people.dart';
import '../models/student.dart';

class MessagesRepository extends ChangeNotifier {
  Student s1 = Student("James", "Bond", 99, Gender.male);
  Student s2 = Student("Dora", "The Explorer", 12, Gender.female);

  final List<Message> messages = [
    Message(
      "Hello!",
      Student("James", "Bond", 99, Gender.male),
      DateTime.now().subtract(
        const Duration(minutes: 3),
      ),
    ),
    Message(
      "How are you?",
      Student("James", "Bond", 99, Gender.male),
      DateTime.now().subtract(
        const Duration(minutes: 3),
      ),
    ),
    Message(
      "Oh, hi!",
      Student("Dora", "The Explorer", 12, Gender.female),
      DateTime.now().subtract(
        const Duration(minutes: 3),
      ),
    ),
    Message(
      "I'm fine.",
      Student("Dora", "The Explorer", 12, Gender.female),
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
