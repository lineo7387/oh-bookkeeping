import 'dart:ui';
import 'package:flutter/material.dart';

/// A widget that adds a soft, atmospheric blurred background effect behind its child.
class AtmosphericBackground extends StatelessWidget {
  final Widget child;

  const AtmosphericBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // Force stack to fill the screen
      children: [
        // Top right primary glow
        Positioned(
          top: -50,
          right: -50,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary.withValues(
                  alpha: 0.4,
                ), // Higher opacity for visibility
              ),
            ),
          ),
        ),
        // Bottom left secondary glow
        Positioned(
          bottom: -100,
          left: -50,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.tertiary.withValues(
                  alpha: 0.4,
                ), // Higher opacity for visibility
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
