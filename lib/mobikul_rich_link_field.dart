library mobikul_rich_link_field;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Enum to define different segment types within the text
/// - [hashtag]: For hashtags (e.g., #example)
/// - [mention]: For mentions (e.g., @username)
/// - [url]: For URLs (e.g., https://example.com)
/// - [normal]: For regular text segments
enum SegmentType {
  hashtag,
  mention,
  url,
  normal,
}

/// Class representing a clickable and interactive segment within the text
/// This class is used to create clickable parts like hashtags, mentions, or URLs
class ClickableSegment {
  final int start; // Start index of the segment in the text
  final int end; // End index of the segment in the text
  final String text; // The actual text of the segment
  final TextStyle style; // Text style for rendering the segment
  final SegmentType
      type; // Type of the segment (hashtag, mention, url, or normal)
  final VoidCallback?
      onTap; // Optional callback triggered when the segment is tapped
  bool isHovered; // Flag to indicate hover state for styling purposes

  /// Constructor to initialize a clickable segment
  ClickableSegment({
    required this.start,
    required this.end,
    required this.text,
    required this.style,
    required this.type,
    this.onTap,
    this.isHovered = false,
  });

  /// Method to get the effective style of the segment
  /// If hovered, the style is slightly modified (color opacity and font size)
  TextStyle get effectiveStyle => style;
}

/// Custom TextEditingController to handle clickable segments in the text
/// It detects and manages hashtags, mentions, and URLs, making them interactive
class ClickableTextFieldController extends TextEditingController {
  final List<ClickableSegment> segments =
      []; // List of clickable segments in the text
  final VoidCallback onSegmentsChanged; // Callback when segments change
  final Function(String, SegmentType)?
      onSegmentTap; // Callback when a segment is tapped

  /// Constructor to initialize the controller
  /// - [onSegmentsChanged] is called when segments are updated or hovered
  /// - [onSegmentTap] is triggered when a segment is tapped
  ClickableTextFieldController({
    required this.onSegmentsChanged,
    this.onSegmentTap,
  });

  /// Builds the TextSpan to render text with clickable segments
  /// This overrides the default behavior to support interactive text
  /// It organizes text into clickable and normal segments using gesture recognizers
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> children = []; // Holds the text parts to be displayed
    String plainText = text; // The full text from the controller
    int currentPosition = 0;

    // Sort segments by start position to maintain the correct order
    segments.sort((a, b) => a.start.compareTo(b.start));

    for (var segment in segments) {
      if (segment.start > currentPosition) {
        // Add normal text before the segment
        children.add(TextSpan(
          text: plainText.substring(currentPosition, segment.start),
          style: style,
        ));
      }

      // Add the clickable segment with gesture recognizers
      children.add(TextSpan(
        text: plainText.substring(segment.start, segment.end),
        style: segment.effectiveStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // Trigger segment's own onTap and parent widget's onSegmentTap
            segment.onTap?.call();
            onSegmentTap?.call(
              plainText.substring(segment.start, segment.end),
              segment.type,
            );
          }
          ..onTapDown = (_) {
            // Handle hover effect on tap down
            segment.isHovered = true;
            notifyListeners();
            onSegmentsChanged();
          }
          ..onTapCancel = () {
            // Remove hover effect if tap is canceled
            segment.isHovered = false;
            notifyListeners();
            onSegmentsChanged();
          }
          ..onTapUp = (_) {
            // Remove hover effect on tap up
            segment.isHovered = false;
            notifyListeners();
            onSegmentsChanged();
          },
      ));

      currentPosition = segment.end;
    }

    // Add remaining normal text after the last segment
    if (currentPosition < plainText.length) {
      children.add(TextSpan(
        text: plainText.substring(currentPosition),
        style: style,
      ));
    }

    return TextSpan(children: children);
  }

  /// Updates segments by detecting hashtags, mentions, and URLs in the text
  /// This uses regular expressions to identify and categorize segments
  void updateSegments() {
    final hashtagPattern = RegExp(r'#\w+'); // Pattern for hashtags
    final mentionPattern = RegExp(r'@\w+'); // Pattern for mentions
    final urlPattern = RegExp(r'https?://\S+'); // Pattern for URLs

    segments.clear(); // Clear existing segments to rebuild

    // Add hashtag segments
    hashtagPattern.allMatches(text).forEach((match) {
      segments.add(
        ClickableSegment(
          start: match.start,
          end: match.end,
          text: text.substring(match.start, match.end),
          type: SegmentType.hashtag,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    });

    // Add mention segments
    mentionPattern.allMatches(text).forEach((match) {
      segments.add(
        ClickableSegment(
          start: match.start,
          end: match.end,
          text: text.substring(match.start, match.end),
          type: SegmentType.mention,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    });

    // Add URL segments
    urlPattern.allMatches(text).forEach((match) {
      segments.add(
        ClickableSegment(
          start: match.start,
          end: match.end,
          text: text.substring(match.start, match.end),
          type: SegmentType.url,
          style: const TextStyle(
            color: Colors.purple,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    });

    notifyListeners(); // Notify listeners about changes
    onSegmentsChanged(); // Trigger callback for UI update
  }
}

/// Main Widget for the rich link text field
/// It supports clickable hashtags, mentions, and URLs with customizable styles
class MobikulRichLinkField extends StatefulWidget {
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final Function(String)? onChanged;
  final Function(String)? onHashtagTap;
  final Function(String)? onMentionTap;
  final Function(String)? onUrlTap;
  final TextStyle? hashtagStyle;
  final TextStyle? mentionStyle;
  final TextStyle? urlStyle;
  final ClickableTextFieldController? controller;

  const MobikulRichLinkField(
      {Key? key,
      this.decoration,
      this.textStyle,
      this.onChanged,
      this.onHashtagTap,
      this.onMentionTap,
      this.onUrlTap,
      this.hashtagStyle,
      this.mentionStyle,
      this.urlStyle,
      this.controller})
      : super(key: key);

  @override
  State<MobikulRichLinkField> createState() => _ClickableTextFieldState();
}

class _ClickableTextFieldState extends State<MobikulRichLinkField> {
  late ClickableTextFieldController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        ClickableTextFieldController(
          onSegmentsChanged: () {
            setState(() {});
          },
          onSegmentTap: _handleSegmentTap,
        );
  }

  /// Handles tap events on hashtags, mentions, and URLs
  /// Calls respective callbacks defined in the parent widget
  void _handleSegmentTap(String text, SegmentType type) {
    switch (type) {
      case SegmentType.hashtag:
        widget.onHashtagTap?.call(text);
        break;
      case SegmentType.mention:
        widget.onMentionTap?.call(text);
        break;
      case SegmentType.url:
        widget.onUrlTap?.call(text);
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: widget.decoration,
      style: widget.textStyle,
      onChanged: (value) {
        _controller.updateSegments();
        widget.onChanged?.call(value);
      },
      maxLines: null, // Allows multi-line input
    );
  }
}
