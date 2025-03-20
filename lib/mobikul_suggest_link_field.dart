
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobikul_rich_link_field/mobikul_rich_link_field.dart';
import 'package:mobikul_suggest_field/mobikul_suggest_field.dart';
import 'package:mobikul_suggest_field/mobikul_suggest_helper.dart';

class MobikulSuggestLinkField extends StatefulWidget {
  final List<Suggestion> suggestions;

  /// Background color for the suggestion box.
  final Color? backgroundColor;

  /// Maximum number of suggestions to display.
  final int maxSuggestions;

  /// Height of each suggestion item.
  final double suggestionItemHeight;

  /// Display style for suggestions (list, grid, or chips).
  final SuggestionDisplayStyle displayStyle;

  /// Highlight color for selected suggestions.
  final Color? highlightColor;

  /// Optional custom text style for suggestions.
  final TextStyle? suggestionStyle;

  /// Callback triggered when a suggestion is selected.
  final Function(Suggestion) onSelected;

  /// Optional custom input decoration.
  final InputDecoration? decoration;

  /// Hint text for the input field.
  final String? hintText;

  final Function(String)? onChanged;
  final Function(String)? onHashtagTap;
  final Function(String)? onMentionTap;
  final Function(String)? onUrlTap;

  const MobikulSuggestLinkField(
      {super.key,
        required this.suggestions,
        this.backgroundColor, this.maxSuggestions = 5,
        this.suggestionItemHeight = 50.0,
        this.highlightColor,
        required this.displayStyle,
        this.suggestionStyle,
        required this.onSelected, this.decoration,
        this.hintText,
        this.onChanged,
        this.onHashtagTap, this.onMentionTap, this.onUrlTap});

  @override
  State<MobikulSuggestLinkField> createState() => _MobikulSuggestLinkFieldState();
}

class _MobikulSuggestLinkFieldState extends State<MobikulSuggestLinkField> {
  late final ClickableTextFieldController _controller;
  List<Suggestion> _filteredSuggestions = [];

  @override
  void initState() {
    _controller = ClickableTextFieldController(
      onSegmentsChanged: () {
        setState(() {});
      },
      onSegmentTap: _handleSegmentTap,
    );
    super.initState();
  }

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

  void _onSuggestionSelected(Suggestion suggestion) {
    String currentText = _controller.text;

    // Determine the last occurrence of @, #, or URL
    int lastAtSymbolIndex = currentText.lastIndexOf('@');
    int lastHashSymbolIndex = currentText.lastIndexOf('#');
    int lastUrlSymbolIndex = currentText.lastIndexOf('http');

    // The position for the symbol is based on the last index of any of the symbols '@', '#', or URL.
    int lastSymbolIndex = max(lastAtSymbolIndex, max(lastHashSymbolIndex, lastUrlSymbolIndex));

    if (lastSymbolIndex != -1) {
      // Check the symbol to determine the type (mention, hashtag, or URL)
      if (currentText[lastSymbolIndex] == '@') {
        // For mentions: Append the suggestion with '@'
        String prefix = currentText.substring(0, lastSymbolIndex);  // Keep all text before '@'
        String newText = '$prefix@${suggestion.name}';  // Add the @ symbol and selected suggestion

        _controller.text = newText;
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: newText.length));
        _controller.updateSegments();  // Update segments for clickable mention
      }
      else if (currentText[lastSymbolIndex] == '#') {
        // For hashtags: Append the suggestion with '#'
        String prefix = currentText.substring(0, lastSymbolIndex);  // Keep all text before '#'
        String newText = '$prefix#${suggestion.name}';  // Add the # symbol and selected suggestion

        _controller.text = newText;
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: newText.length));
        _controller.updateSegments();  // Update segments for clickable hashtag
      }
      else if (currentText.startsWith('http', lastSymbolIndex)) {
        // For URLs: Handle URL insertion
        String prefix = currentText.substring(0, lastSymbolIndex);  // Keep all text before URL
        String newText = '$prefix${suggestion.name}';  // Directly add the URL

        _controller.text = newText;
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: newText.length));
        _controller.updateSegments();  // Update segments for clickable URL
      }
    }

    // Call the parent widget's onSelected callback to notify the selection
    widget.onSelected(suggestion);

    // Clear the filtered suggestions
    _filteredSuggestions.clear();
  }

  void _onTextChanged() {
    setState(() {
      String inputText = _controller.text;

      // Show suggestions only when '@' or '#' is found in the text
      if (inputText.contains('@') || inputText.contains('#')) {
        // Extract the part of the text after '@' or '#'
        String searchText = inputText.split(RegExp(r'[@#]')).last;

        // Filter suggestions based on the text that follows '@' or '#'
        _filteredSuggestions = widget.suggestions
            .where((suggestion) => suggestion.name
            .toLowerCase()
            .contains(searchText.toLowerCase()))
            .toList();
      } else {
        // If no '@' or '#' is found, don't show suggestions
        _filteredSuggestions.clear();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        MobikulRichLinkField(
          controller: _controller,
          decoration: widget.decoration ?? InputDecoration(
            hintText: widget.hintText ?? 'Type with #hashtags, @mentions, or https://urls...',
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(16),
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
            _onTextChanged();
            if(widget.onChanged != null){
              widget.onChanged!(value);
            }
          },
          onHashtagTap: (hashtag) {
            if(widget.onHashtagTap != null){
              widget.onHashtagTap!(hashtag);
            }
          },
          onMentionTap: (mention) {
            if(widget.onMentionTap != null){
              widget.onMentionTap!(mention);
            }
          },
          onUrlTap: (url) {
            if(widget.onUrlTap != null){
              widget.onUrlTap!(url);
            }
          },
        ),
        if (_filteredSuggestions.isNotEmpty)
          Container(
            constraints: BoxConstraints(
              maxHeight: widget.suggestionItemHeight * widget.maxSuggestions,
            ),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SuggestHelper.buildSuggestionsList(
                _filteredSuggestions, widget.displayStyle,
                text: _controller.text,
                highlightColor: widget.highlightColor,
                suggestionStyle: widget.suggestionStyle,
                onSuggestionSelected:
                _onSuggestionSelected), // Display the filtered suggestions
          )
      ],
    );
  }
}
