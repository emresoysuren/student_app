import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app/repository/messages_repository.dart';

import '../models/message.dart';

class MessagesPage extends ConsumerStatefulWidget {
  const MessagesPage({super.key});

  @override
  ConsumerState<MessagesPage> createState() => MessagesPageState();
}

class MessagesPageState extends ConsumerState<MessagesPage> {
  TextEditingController messageBoxController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero)
        .then((value) => ref.read(messagesProvider).clearMessages());
    super.initState();
  }

  @override
  void dispose() {
    messageBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MessagesRepository messagesRepository = ref.watch(messagesProvider);
    return Scaffold(
      backgroundColor: const Color(0xffe8eddf),
      appBar: AppBar(
        title: const Text("Messages Page"),
        backgroundColor: const Color(0xff540d6e),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messagesRepository.messages.length,
              itemBuilder: (context, index) {
                return MessageItem(
                  message:
                      messagesRepository.messages.reversed.elementAt(index),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: const BoxDecoration(),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    decoration: const BoxDecoration(
                        color: Color(0xff540d6e),
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(32),
                            right: Radius.circular(16))),
                    child: TextField(
                      controller: messageBoxController,
                      style: const TextStyle(
                        color: Color(0xfff3fcf0),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  width: 64,
                  height: 59,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  decoration: const BoxDecoration(
                      color: Color(0xffffd23f),
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(16),
                          right: Radius.circular(32))),
                  child: IconButton(
                    onPressed: () => print("Send"),
                    icon: Transform.rotate(
                      angle: pi * -0.25,
                      child: const Icon(
                        Icons.send,
                        color: Color(0xff540d6e),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.sender.name == "Dora"
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xffee4266),
          borderRadius: message.sender.name == "Dora"
              ? const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(6),
                  bottomLeft: Radius.circular(16),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(6),
                ),
        ),
        child: Text(
          message.text,
          style: const TextStyle(
              color: Color(0xfff3fcf0),
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
