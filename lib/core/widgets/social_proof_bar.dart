import 'package:flutter/material.dart';

import 'stat_block.dart';
import 'ghost_divider.dart';

class SocialProofBarModule extends StatelessWidget {
  const SocialProofBarModule({super.key});

  @override
  Widget build(BuildContext context) {
    // IntrinsicHeight is the secret weapon here. It forces the Row to figure out
    // exactly how tall the StatBlocks are, so the Ghost Divider knows how far to stretch.
    return IntrinsicHeight(
      child: Row(
        children: [
          const StatBlock(
            value: "4.8k+",
            label:
                "Curators", // Notice we didn't capitalize this? The LabelText element does it for us!
          ),

          const SizedBox(width: 24), // The left gap

          const GhostVerticalDivider(), // Your 15% opacity line

          const SizedBox(width: 24), // The right gap

          const StatBlock(value: "Refined", label: "Interface"),
        ],
      ),
    );
  }
}
