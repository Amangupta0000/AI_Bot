import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenAIService {
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final response = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer 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"
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content":
                    "Does this message want to generate an AI art , picture,image or anything similar? $prompt .Simply answer with a Yes or No. ",
              },
            ]
          }));
      print(response.body);
      if (response.statusCode == 200) {
        String content =
            jsonDecode(response.body)['choices'][0]['message']['content'];
        content.trim();
        content.toLowerCase();
        switch (content) {
          case 'yes':
            final res = await dallEAPI(prompt);
            return res;
          default:
            final res = await chatGPTAPI(prompt);
            return res;
        }
      }
      return 'An internal error occured';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    return 'chatgpt';
  }

  Future<String> dallEAPI(String prompt) async {
    return 'dalleapi';
  }
}
