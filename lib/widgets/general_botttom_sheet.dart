import 'package:flutter/material.dart';

class GeneralButtomSheet {
  customBottomSheet(BuildContext context) {
    final todoController = TextEditingController();
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 10,
              right: 16,
              left: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: todoController,
                  decoration: InputDecoration(
                    hintText: 'Enter a todo',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(todoController.text);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        });
  }
}
