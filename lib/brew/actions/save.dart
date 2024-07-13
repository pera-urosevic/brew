import 'package:flutter/material.dart';

class ActionSave extends StatefulWidget {
  final Function(String name) onSave;
  const ActionSave({super.key, required this.onSave});

  @override
  State<ActionSave> createState() => _ActionSaveState();
}

class _ActionSaveState extends State<ActionSave> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.star),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Name'),
            content: TextField(
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              onSubmitted: (nameSubmitted) {
                if (nameSubmitted.isNotEmpty) {
                  widget.onSave(nameSubmitted);
                  Navigator.pop(context);
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (name.isNotEmpty) {
                    widget.onSave(name);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
