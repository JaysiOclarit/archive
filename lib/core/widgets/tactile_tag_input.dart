import 'package:archive/core/widgets/label_text.dart';
import 'package:flutter/material.dart';

class TactileTagInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final List<String> initialTags;
  final ValueChanged<List<String>> onTagsChanged;

  const TactileTagInput({
    super.key,
    required this.label,
    required this.placeholder,
    this.initialTags = const [],
    required this.onTagsChanged,
  });

  @override
  State<TactileTagInput> createState() => _TactileTagInputState();
}

class _TactileTagInputState extends State<TactileTagInput> {
  late List<String> _tags;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.initialTags);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addTag(String value) {
    // Remove commas and trim whitespace
    final tag = value.replaceAll(',', '').trim();

    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
      });
      widget.onTagsChanged(_tags);
    }
    _controller.clear();
    _focusNode.requestFocus(); // Keep keyboard open after adding
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    widget.onTagsChanged(_tags);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. The Top Label (Reusing your tiny Manrope caps)
        LabelText(widget.label),
        const SizedBox(height: 8),

        // 2. The Main Input Container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary, // White Paper fill
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outlineVariant, // Subtle outline
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3. The Tags (Chips)
              if (_tags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _tags.map((tag) {
                      return InputChip(
                        label: Text(tag),
                        // Utility typography (Manrope)
                        labelStyle: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        backgroundColor:
                            theme.colorScheme.surfaceDim, // Dim Paper
                        deleteIcon: Icon(
                          Icons.close,
                          size: 16,
                          color: theme.colorScheme.onSurface.withAlpha(
                            (0.6 * 255).round(),
                          ),
                        ),
                        onDeleted: () => _removeTag(tag),
                        // Removing shadows/borders for the editorial look
                        elevation: 0,
                        pressElevation: 0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          side: BorderSide.none,
                        ),
                      );
                    }).toList(),
                  ),
                ),

              // 4. The actual Text Input Area
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: theme.textTheme.bodyLarge,
                // Add tag when user presses "Enter" on keyboard
                onSubmitted: _addTag,
                // Optional: Also add tag if they type a comma
                onChanged: (value) {
                  if (value.endsWith(',')) {
                    _addTag(value);
                  }
                },
                decoration: InputDecoration(
                  hintText: _tags.isEmpty
                      ? widget.placeholder
                      : "Add another...",
                  hintStyle: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(
                      (0.4 * 255).round(),
                    ),
                  ),
                  // We strip out the default InputDecoration borders because
                  // our parent Container is handling the visual border.
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
