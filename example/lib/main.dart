import 'package:flutter/material.dart';
import 'package:mobikul_suggest_field/mobikul_suggest_field.dart';
import 'package:mobikul_suggest_link_field/mobikul_suggest_link_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Suggestion> suggestions = [
      Suggestion(name: 'Canada', icon: Icons.flag),
      Suggestion(name: 'Australia', icon: Icons.public),
      Suggestion(name: 'Germany', icon: Icons.language),
      Suggestion(name: 'France', icon: Icons.map),
      Suggestion(name: 'Italy', icon: Icons.travel_explore),
      Suggestion(name: 'Spain', icon: Icons.flight),
      Suggestion(name: 'Japan', icon: Icons.location_on),
      Suggestion(name: 'China', icon: Icons.apartment),
      Suggestion(name: 'India', icon: Icons.place),
      Suggestion(name: 'Brazil', icon: Icons.explore),
      Suggestion(name: 'Mexico', icon: Icons.terrain),
      Suggestion(name: 'Russia', icon: Icons.landscape),
      Suggestion(name: 'South Korea', icon: Icons.route),
      Suggestion(name: 'Argentina', icon: Icons.airplanemode_active),
      Suggestion(name: 'Belgium', icon: Icons.business),
      Suggestion(name: 'South Africa', icon: Icons.nature),
      Suggestion(name: 'Switzerland', icon: Icons.star),
      Suggestion(name: 'Sweden', icon: Icons.home),
      Suggestion(name: 'Netherlands', icon: Icons.account_balance),
      Suggestion(name: 'Norway', icon: Icons.museum),
      Suggestion(name: 'Greece', icon: Icons.beach_access),
      Suggestion(name: 'Egypt', icon: Icons.directions_boat),
      Suggestion(name: 'Thailand', icon: Icons.wb_sunny),
      Suggestion(name: 'Singapore', icon: Icons.eco),
      Suggestion(name: 'Turkey', icon: Icons.forest),
      Suggestion(name: 'Poland', icon: Icons.military_tech),
      Suggestion(name: 'Israel', icon: Icons.sports_soccer),
      Suggestion(name: 'Denmark', icon: Icons.sports_basketball),
      Suggestion(name: 'Finland', icon: Icons.sports_cricket),
      Suggestion(name: 'Indonesia', icon: Icons.monetization_on),
      Suggestion(name: 'Malaysia', icon: Icons.flag), // Icons repeat from start
      Suggestion(name: 'Vietnam', icon: Icons.public),
      Suggestion(name: 'Saudi Arabia', icon: Icons.language),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Mobikul Combined Field")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MobikulSuggestLinkField(
              displayStyle: SuggestionDisplayStyle.chips,
              suggestions: suggestions,
              decoration: InputDecoration(
                labelText: 'Search Countries',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
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
              onSelected: (value) {
                setState(() {});
              },
              hintText: 'Search Countries',
            ),
          ],
        ),
      ),
    );
  }
}
