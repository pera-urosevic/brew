import 'package:flutter/material.dart';

class Save extends StatefulWidget {
  final Function(String name) onSave;
  const Save({super.key, required this.onSave});

  @override
  State<Save> createState() => _SaveState();
}

class _SaveState extends State<Save> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.save),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
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
