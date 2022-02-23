import 'package:flutter/material.dart';

class GeneralAlertDialog {
  customAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  customLoadingDialog(BuildContext context){
    showDialog(context: context, builder: (_) => AlertDialog(
      content: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 10,),
          Text("Loading"),

        ],
      ),


    ),
    );
  }
}
