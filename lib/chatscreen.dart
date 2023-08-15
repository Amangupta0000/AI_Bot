import 'package:aibot/chatmessages.dart';
import 'package:aibot/threedots.dart';
// import 'package:aibot/opeai_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool istyping = false;
  final TextEditingController _senderText = TextEditingController();
  final List<ChatMessages> _messages = [];
  // final OpenAIService openAIService = OpenAIService();

  void sendMessage() async {
    ChatMessages _message =
        ChatMessages(sender: 'user', text: _senderText.text);
    setState(() {
      _messages.insert(0, _message);
      istyping = true;
    });
    final response =
        await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer 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"
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo-0613",
              "messages": [
                {
                  "role": "user",
                  "content": _senderText.text,
                },
              ]
            }));

    if (response.statusCode == 200) {
      String reply =
          jsonDecode(response.body)['choices'][0]['message']['content'];
      ChatMessages botmessage = ChatMessages(sender: 'bot', text: reply);
      setState(() {
        istyping = false;
        _messages.insert(0, botmessage);
      });
    }
    _senderText.clear();
    // openAIService.isArtPromptAPI(_senderText.text);
  }

  Widget _messageField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _senderText,
            onSubmitted: (value) => sendMessage(),
            decoration: InputDecoration(
              fillColor: Colors.grey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusColor: Colors.white,
              hintText: "  Type Here ...",
            ),
          ),
        ),
        IconButton(
            onPressed: () => sendMessage(), icon: const Icon(Icons.send)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Chatgpt'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(15),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            if (istyping) const ThreeDots(),
            Divider(),
            Container(child: _messageField()),
          ],
        ),
      ),
    );
  }
}
