import 'package:flutter/material.dart';
import 'package:freeman/controller/important_note_controller.dart';

class ImportantNote extends StatelessWidget {
  const ImportantNote({Key? key, this.color}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 300,
      right: 10,
      child: Container(
        width: 150,
        height: 30,
        color: ImportantNoteController.color,
        child: Center(
            child: Text(ImportantNoteController.note,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16))),
      ),
    );
  }
}
