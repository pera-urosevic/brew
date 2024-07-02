import 'package:brew/theme/input/decoration.dart';
import 'package:flutter/material.dart';

class ActionNotes extends StatefulWidget {
  final String notes;
  final Function(String notes) onSave;
  const ActionNotes({super.key, required this.notes, required this.onSave});

  @override
  State<ActionNotes> createState() => _ActionNotesState();
}

class _ActionNotesState extends State<ActionNotes> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notes),
      onPressed: () {
        TextEditingController notesController = TextEditingController(text: widget.notes);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Notes'),
            content: TextField(
              autofocus: true,
              controller: notesController,
              minLines: 4,
              maxLines: 8,
              decoration: inputDecoration,
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
                  widget.onSave(notesController.text);
                  Navigator.pop(context);
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        );
      },
    );
  }
}
