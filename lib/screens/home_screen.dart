
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final firestore = FirebaseFirestore.instance;
    final stream = firestore.collection(TodoConstants.todo).doc('MwgsQop14nXbYUNRnngB');
    stream.get().then((value) => log(value.data().toString()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Application'),
        centerTitle: true,
      ),
      body: Padding(
        padding: basepadding,
        child: Column(
          children: const [
            Text('Home Screen'),
          ],
        ),
      ),
      
    );
  }
}