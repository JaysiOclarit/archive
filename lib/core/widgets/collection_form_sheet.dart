import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archive/core/widgets/tactile_input_field.dart';
import 'package:archive/core/widgets/tactile_button.dart';
import 'package:archive/core/widgets/label_text.dart';
import 'package:archive/features/collection/presentation/bloc/collection_cubit.dart';
import 'package:archive/features/collection/domain/entities/collection_entity.dart';

class CollectionFormSheet extends StatefulWidget {
  const CollectionFormSheet({super.key});

  @override
  State<CollectionFormSheet> createState() => _CollectionFormSheetState();
}

class _CollectionFormSheetState extends State<CollectionFormSheet> {
  final TextEditingController _nameController = TextEditingController();

  // A curated list of beautiful, thin-line icons for the user to choose from
  final List<IconData> _availableIcons = [
    Icons.folder_outlined,
    Icons.book_outlined,
    Icons.lightbulb_outlined,
    Icons.work_outline,
    Icons.architecture,
    Icons.auto_awesome_outlined,
    Icons.favorite_border,
    Icons.push_pin_outlined,
    Icons.article_outlined,
    Icons.color_lens_outlined,
  ];

  // Default to the first icon (Folder)
  late IconData _selectedIcon;

  @override
  void initState() {
    super.initState();
    _selectedIcon = _availableIcons.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveCollection() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please give your collection a name.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    // Create the Collection Entity
    final newCollection = CollectionEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId:
          '', // Your repository layer should inject the actual logged-in user ID
      name: name,
      notes: '',
      iconCodePoint: _selectedIcon.codePoint,
      iconFontFamily: _selectedIcon.fontFamily,
      bookmarks: const [], // Starts empty
      createdAt: DateTime.now(),
    );

    // Save via Cubit and close the sheet
    context.read<CollectionCubit>().addCollection(newCollection);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Header
        Text("New Collection", style: theme.textTheme.headlineMedium),
        const SizedBox(height: 24),

        // 2. Name Input Field
        TactileInputField(
          label: "COLLECTION NAME",
          placeholder: "e.g., UI Inspiration, Flutter Tips...",
          controller: _nameController,
        ),
        const SizedBox(height: 24),

        // 3. Icon Picker Section
        const LabelText("CHOOSE AN ICON"),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12, // Horizontal space between icons
          runSpacing: 12, // Vertical space between rows
          children: _availableIcons.map((icon) {
            final isSelected = _selectedIcon == icon;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIcon = icon;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // Moss Green if selected, Dim Paper if unselected
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surfaceDim,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? null
                      : Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  // White if selected, Charcoal if unselected
                  color: isSelected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface.withAlpha(
                          (0.6 * 255).round(),
                        ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),

        // 4. Submit Button
        TactileButton(
          text: "Create Collection",
          isPrimary: true, // Uses Moss Green
          onPressed: _saveCollection,
        ),
      ],
    );
  }
}
