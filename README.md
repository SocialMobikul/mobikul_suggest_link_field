# Mobikul Suggest Link Field Flutter Package

The `MobikulSuggestLinkField` is a highly customizable Flutter widget designed to provide a suggestion input field with features like search-as-you-type, auto-completion, and dynamic suggestions based on user input. This widget is perfect for enhancing user experience when inputting search queries, mentions, hashtags, or URLs.

To find out more: https://mobikul.com/

## Features

- **Search-as-you-type**: Automatically provides suggestions based on user input.
- **Custom Suggestions**: Display custom suggestions with any widget (e.g., icons, text).
- **Auto-completion**: Provides suggested text that automatically fills in the input field as you type.
- **Theme Customization**: Full customization for the appearance of the suggestion field.
- **Multiple Input Types**: Works with text, numbers, mentions (`@`), hashtags (`#`), and URLs (`https://`).
- **Link Behavior**: Supports clickable mentions, hashtags, and URLs.

## Installation

To add `mobikul_suggest_link_field` to your project, include the following in your `pubspec.yaml` file:

```yaml
dependencies:
  mobikul_suggest_link_field: # ^latest version

```

## Usage
### Import the Package
```dart
  import 'package:mobikul_suggest_link_field/mobikul_suggest_link_field.dart';
```
### Basic Mobikul Suggest Link Field Example
```dart
MobikulSuggestLinkField(
suggestions: _suggestions, // List of suggestions to display
displayStyle: SuggestionDisplayStyle.list, // Display style (list, grid, or chips)
onSelected: (Suggestion selected) {
// Handle the selected suggestion
print('Selected suggestion: ${selected.name}');
},
onHashtagTap: (hashtag) {
// Handle hashtag tap
print('Hashtag tapped: $hashtag');
},
onMentionTap: (mention) {
// Handle mention tap
print('Mention tapped: $mention');
},
onUrlTap: (url) {
// Handle URL tap
print('URL tapped: $url');
},
hintText: 'Type with #hashtags, @mentions, or URLs...',
maxSuggestions: 5,
suggestionItemHeight: 50.0,
backgroundColor: Colors.white,
highlightColor: Colors.blue,
suggestionStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
onChanged: (text) {
// Handle text change
print('Text changed: $text');
},
)

```

### You can customize various aspects of the MobikulSuggestLinkField widget as shown below:
```dart
MobikulSuggestLinkField(
suggestions: _suggestions,
displayStyle: SuggestionDisplayStyle.grid, // Grid display style
maxSuggestions: 5,
suggestionItemHeight: 50.0,
backgroundColor: Theme.of(context).cardColor,
highlightColor: Theme.of(context).primaryColor,
suggestionStyle: TextStyle(fontSize: 14, color: Colors.grey[800]),
onSelected: (selected) {
print('Selected suggestion: ${selected.name}');
},
onChanged: (value) {
print('Text changed: $value');
},
onHashtagTap: (hashtag) {
print('Hashtag tapped: $hashtag');
},
onMentionTap: (mention) {
print('Mention tapped: $mention');
},
onUrlTap: (url) {
print('URL tapped: $url');
},
)

```

### Input Field Customization
```dart

MobikulSuggestLinkField(
suggestions: _suggestions,
hintText: 'Type with #hashtags, @mentions, or URLs...',
decoration: InputDecoration(
labelText: 'Search for hashtags, mentions, or URLs',
border: OutlineInputBorder(),
filled: true,
fillColor: Colors.grey[100],
),
textStyle: TextStyle(fontSize: 16),
)


```




## Output

Here are some examples of how the MobikulSuggestLinkField widget behaves:

## Basic MobikulSuggestLinkField
![Basic MobikulSuggestLinkField](https://raw.githubusercontent.com/SocialMobikul/mobikul_suggest_link_field/main/basic_field.gif)

## Customize MobikulSuggestLinkField
![Advance MobikulSuggestLinkField](https://raw.githubusercontent.com/SocialMobikul/mobikul_suggest_link_field/main/customized_field.gif)

## Decoration MobikulSuggestLinkField
![MobikulSuggestLinkField with Decoration](https://raw.githubusercontent.com/SocialMobikul/mobikul_suggest_link_field/main/decoration_field.gif)


Start building amazing SuggestLinkField today with the `MobikulSuggestLinkField` package! 🚀