import 'dart:html';

import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  final String sender;
  final String text;

  const ChatMessages({super.key, required this.sender, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 13),
          child: Container(
            height: 35,
            width: 45,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(top: 4, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:
                    (sender == 'user') ? Colors.purple[200] : Colors.red[400]),
            child: Text(sender.toString()),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(text),
          ),
        ),
      ],
    );
  }
}
