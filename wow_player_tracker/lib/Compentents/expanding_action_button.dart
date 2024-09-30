import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wow_player_tracker/Compentents/state_manage_Controller.dart';


@immutable
class ExpandingActionButton extends StatelessWidget {
  const ExpandingActionButton({super.key, 
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    context.watch<StateManageController>().open;
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 2.0),
          progress.value * maxDistance,

        );
        return Positioned(
          right: 175.0 + offset.dx,
          bottom: 450 + offset.dy,
          child: Row(
            children: [child!],
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

