# Mobikul Rich Link Field Flutter Package

The `MobikulRichLinkField` is a powerful Flutter package that provides a text field with clickable segments for hashtags, mentions, and URLs. It allows you to easily create rich text experiences with interactive elements, perfect for social media applications, chat interfaces, and more.

To find out more: https://mobikul.com/

## Features

- **Clickable Hashtags**: Detect and highlight hashtags with custom styles and tap actions.
- **Mentions**: Automatically recognize mentions (e.g., @username) and make them tappable.
- **URL Detection**: Identify and style URLs with underlines, and open them on tap.
- **Customizable Styles**: Fully customize the appearance of hashtags, mentions, and URLs.
- **Hover Effects**: Subtle hover effects for better UX.
- **Flexible Callbacks**: Easily handle taps on different segment types.

## Installation

To add `MobikulRichLinkField` to your project, include the following in your `pubspec.yaml` file:

```yaml
dependencies:
  mobikul_rich_link_field: # ^latest version
```

Then, fetch the package using the command:

```bash
flutter pub get
```

## Usage

### Import the Package
```dart
import 'package:mobikul_rich_link_field/mobikul_rich_link_field.dart';
```

### Basic Example
```dart
MobikulRichLinkField(
  decoration: InputDecoration(
    hintText: 'Type a message...'
  ),
  onHashtagTap: (hashtag) => print('Hashtag tapped: \$hashtag'),
  onMentionTap: (mention) => print('Mention tapped: \$mention'),
  onUrlTap: (url) => print('URL tapped: \$url'),
);
```

### Custom Styles and Callbacks
```dart
MobikulRichLinkField(
  hashtagStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
  mentionStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
  urlStyle: TextStyle(color: Colors.purple, decoration: TextDecoration.underline),
  onHashtagTap: (hashtag) => print('Tapped on hashtag: \$hashtag'),
  onMentionTap: (mention) => print('Tapped on mention: \$mention'),
  onUrlTap: (url) => print('Tapped on URL: \$url'),
);
```

## Parameters

| Property           | Type                  | Description                                      |
|-------------------|-----------------------|--------------------------------------------------|
| `onHashtagTap`     | `Function(String)`     | Callback when a hashtag is tapped.                |
| `onMentionTap`     | `Function(String)`     | Callback when a mention is tapped.                |
| `onUrlTap`         | `Function(String)`     | Callback when a URL is tapped.                    |
| `hashtagStyle`     | `TextStyle?`           | Custom style for hashtags.                       |
| `mentionStyle`     | `TextStyle?`           | Custom style for mentions.                       |
| `urlStyle`         | `TextStyle?`           | Custom style for URLs.                           |
| `textStyle`        | `TextStyle?`           | General text style for the input field.           |

## Output

Here’s an example of the `MobikulRichLinkField` in action:

## Basic Text Field
![basic Text Field](https://raw.githubusercontent.com/SocialMobikul/mobikul_rich_link_field/main/basic_package.gif)

## Rich Text Field For Mention, Hashtag and URL detection
![Rich Text Field](https://raw.githubusercontent.com/SocialMobikul/mobikul_rich_link_field/main/package_feature.gif)


Start building interactive text fields today with the `MobikulRichLinkField` package! 🚀
