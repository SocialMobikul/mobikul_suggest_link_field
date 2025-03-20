import 'package:flutter/material.dart';
import 'package:mobikul_rich_link_field/mobikul_rich_link_field.dart';

void main() {
  runApp(
    MaterialApp(
      home: const MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
    ),
  );
}

// Example usage
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive TextField')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MobikulRichLinkField(
          decoration: const InputDecoration(
            hintText: 'Type with #hashtags, @mentions, or https://urls...',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(16),
          ),
          textStyle: const TextStyle(fontSize: 16),
          hashtagStyle: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
          mentionStyle: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
          urlStyle: const TextStyle(
            color: Colors.purple,
            decoration: TextDecoration.underline,
          ),
          onChanged: (value) {
            debugPrint('Text changed: $value');
          },
          onHashtagTap: (hashtag) {
            debugPrint('Hashtag tapped: $hashtag');
            // Show hashtag details or navigate to hashtag page
          },
          onMentionTap: (mention) {
            debugPrint('Mention tapped: $mention');
            // Show user profile or navigate to user page
          },
          onUrlTap: (url) {
            debugPrint('URL tapped: $url');
            // Open URL in browser or show preview
          },
        ),
      ),
    );
  }
}
