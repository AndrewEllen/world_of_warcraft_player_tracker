//Class Button Starter
import 'dart:math';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wow_player_tracker/Compentents/statemanageController.dart';
import 'expandingactionbutton.dart';


@immutable
class ExpandableFab extends StatefulWidget {
  ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });


  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}


mixin math {
}


class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _expandAnimation;
  late AnimationController controller;


  @override
  void initState() {
    super.initState();
    context.read<StateManageController>().open ?? false;

    controller = AnimationController(
      value: context.read<StateManageController>().open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent:  controller,
    );

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _toggle() {

    context.read<StateManageController>().setOpenState();
    setState(() {

      if (context.read<StateManageController>().open) {
        controller.forward();
      } else {
        controller.reverse();
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    context.watch<StateManageController>().open;

    if(!context.read<StateManageController>().open){

      controller.reverse();

    }

    return SizedBox.expand(
      child: Stack(
        //aligment controles where it is
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }


  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }


  //this handles the little bittons
  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 140.0 / (count);
    for (var i = 0, angleInDegrees =1.0;
    i < count;
    i++, angleInDegrees += step) {
      children.add(
        ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }
// the main open and close widget
  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: context.read<StateManageController>().open,
      child: AnimatedContainer(
        transformAlignment: Alignment.bottomCenter,
        transform: Matrix4.diagonal3Values(
          context.read<StateManageController>().open ? 0.7 : 1.0,
          context.read<StateManageController>().open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: context.read<StateManageController>().open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}
