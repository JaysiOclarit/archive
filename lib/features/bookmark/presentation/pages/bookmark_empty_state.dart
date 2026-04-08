import 'dart:async';
import 'dart:math' as math;

import 'package:archive/core/widgets/app_bar.dart';
import 'package:archive/core/widgets/bookmark_form_sheet.dart';
import 'package:archive/core/widgets/tactile_button.dart';
import 'package:archive/core/widgets/tactile_modal_sheet.dart';
import 'package:archive/features/bookmark/presentation/bloc/bookmark_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkEmptyState extends StatefulWidget {
  const BookmarkEmptyState({super.key});

  @override
  State<BookmarkEmptyState> createState() => _BookmarkEmptyStateState();
}

class _BookmarkEmptyStateState extends State<BookmarkEmptyState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  Timer? _timer;
  final _random = math.Random();
  late final BookmarkCubit currentCubit;

  @override
  void initState() {
    super.initState();
    currentCubit = context.read<BookmarkCubit>();
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
    return Scaffold(
      appBar: const ArchiveAppBar(title: "The Archive"),
      backgroundColor: theme.colorScheme.surfaceContainerLow,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                // Put empty_state_bookmark.png in the assets/images folder and reference it here
                children: [
                  const SizedBox(height: 48),
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
                        'lib/core/assets/images/empty_state_bookmark.png',
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
                      // Use the font method directly here
                      textStyle: theme
                          .textTheme
                          .labelMedium, // Merge with your existing theme
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 2. For the Headline (using Newsreader)
                  Padding(
                    padding: const EdgeInsets.only(left: 37.0, right: 37.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Your Archive is a Blank Page",
                      style: GoogleFonts.newsreader(
                        // Make the headline larger and bolder, and make it italic
                        // Text align and indent center
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        textStyle: theme
                            .textTheme
                            .headlineLarge, // Merge with your existing theme
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "The first mark is always the most meaningful. Add a link to begin your collection.",
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        textStyle: theme
                            .textTheme
                            .bodyMedium, // Merge with your existing theme
                        color: theme.colorScheme.onSurfaceVariant.withAlpha(
                          (0.8 * 255).round(),
                        ),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  TactileButton(
                    icon: Icon(Icons.add),
                    text: "Add your First Artifact",
                    onPressed: () {
                      // Triggering the Input Form
                      showTactileBottomSheet(
                        context: context,
                        child: BlocProvider.value(
                          // 2. Pass it into the bottom sheet's new widget tree
                          value: currentCubit,
                          child: const BookmarkFormSheet(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
