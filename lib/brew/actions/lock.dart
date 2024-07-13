import 'package:flutter/material.dart';

class ActionLock extends StatefulWidget {
  final Icon icon;
  final Function() onLock;
  const ActionLock({super.key, required this.icon, required this.onLock});

  @override
  State<ActionLock> createState() => _ActionLockState();
}

class _ActionLockState extends State<ActionLock> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.icon,
      onPressed: () => widget.onLock(),
    );
  }
}
