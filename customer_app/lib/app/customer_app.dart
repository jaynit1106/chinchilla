import 'package:flutter/material.dart';

class CustomerApp extends StatelessWidget {
  void answerQuestion() {
    print('Answer chosen');
  }

  @override
  Widget build(BuildContext context) {
    List<String> questions = ["What's your name?", "Who are you?"];
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer App'),
        primary: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: answerQuestion,
          ),
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: answerQuestion,
          ),
          IconButton(
            icon: Icon(Icons.notification_important),
            onPressed: answerQuestion,
          ),
          IconButton(
            icon: Icon(Icons.notifications_active),
            onPressed: answerQuestion,
          ),
        ],
      ),
      body: Column(
        children: questions
            .map((question) => Column(
                  children: [
                    Text(question),
                    ElevatedButton(
                        onPressed: answerQuestion, child: Text('Answer 1')),
                    ElevatedButton(
                        onPressed: answerQuestion, child: Text('Answer 2')),
                    ElevatedButton(
                        onPressed: answerQuestion, child: Text('Answer 3')),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
