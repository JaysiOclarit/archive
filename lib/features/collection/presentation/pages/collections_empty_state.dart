import 'dart:async';
import 'dart:math' as math;

import 'package:archive/core/widgets/collection_form_sheet.dart';
import 'package:archive/core/widgets/tactile_button.dart';
import 'package:archive/core/widgets/tactile_modal_sheet.dart';
import 'package:archive/features/collection/presentation/bloc/collection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CollectionsEmptyState extends StatefulWidget {
  const CollectionsEmptyState({super.key});

  @override
  State<CollectionsEmptyState> createState() => _CollectionsEmptyStateState();
}

class _CollectionsEmptyStateState extends State<CollectionsEmptyState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  Timer? _timer;
  final _random = math.Random();
  late final CollectionCubit currentCubit; // Swapped to CollectionCubit

  @override
  void initState() {
    super.initState();
    currentCubit = context.read<CollectionCubit>();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _scheduleNext();
  }

  void _scheduleNext() {
    final delay = Duration(seconds: 4 + _random.nextInt(7));
    _timer = Timer(delay, () {
      if (!mounted) return;
      _controller.forward(from: 0.0).whenComplete(() {
        if (!mounted) return;
        _scheduleNext();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Removed Scaffold and SafeArea so this slots cleanly inside the existing CollectionsPage Expanded body
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              // wrap image in a container to give it a background color white, some padding, rounded corners to make it look like a card, and tilt it slightly for a playful effect
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme
                      .colorScheme
                      .surfaceContainerHighest, // Use a variant for contrast
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final t = _animation.value;
                    final wobble = math.sin(t * math.pi * 2) * 0.07;
                    final angle = -0.05 + wobble;
                    final dx = math.sin(t * math.pi * 2) * 6.0;
                    return Transform.rotate(
                      angle: angle,
                      child: Transform.translate(
                        offset: Offset(dx, 0),
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset(
                    'lib/core/assets/images/empty_state_bookmark.png', // You can swap this for a folder image later!
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 1. For the "FOUNDATION" label (using Manrope)
              Text(
                "FOUNDATION",
                style: GoogleFonts.manrope(
                  textStyle: theme.textTheme.labelMedium,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 15),

              // 2. For the Headline (using Newsreader)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "No collections yet, but the foundation is set.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.newsreader(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    textStyle: theme.textTheme.headlineLarge,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Start building your archive by creating a collection and adding artifacts to it.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    textStyle: theme.textTheme.bodyMedium,
                    color: theme.colorScheme.onSurfaceVariant.withAlpha(
                      (0.8 * 255).round(),
                    ),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              TactileButton(
                icon: const Icon(Icons.add),
                text: "Create Your First Collection",
                onPressed: () {
                  // TODO: Create a CollectionFormSheet and trigger it here
                  // Since you don't have a CollectionFormSheet built yet, this is a placeholder print.
                  debugPrint("Open Collection Form Modal");
                  // Grab the cubit to pass to the modal
                  final currentCubit = context.read<CollectionCubit>();

                  showTactileBottomSheet(
                    context: context,
                    child: BlocProvider.value(
                      value: currentCubit,
                      child:
                          const CollectionFormSheet(), // Trigger your new sheet!
                    ),
                  );
                },
              ),
              const SizedBox(height: 24), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
