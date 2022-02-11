
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/constants/constants.dart';
import 'package:todo_application/models/todo_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final fireStore = FirebaseFirestore.instance;
    final collection = fireStore.collection(TodoConstants.todo);
    // final stream = firestore.collection(TodoConstants.todo).doc('MwgsQop14nXbYUNRnngB');
    // stream.get().then((value) => log(value.data().toString()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Application'),
        centerTitle: true,
      ),
      body: Padding(
        padding: basepadding,
        child: StreamBuilder(
         
          stream: collection
          .orderBy('date')
          .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            print(snapshot.data!.docs.last.data());
          
  
            return SingleChildScrollView(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              final data = snapshot.data!.docs[index].data()! as Map;
              final todo = TodoModel.fromjson(data);
              print(data);
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.date),
                trailing: Icon(
                  todo.isCompleted
                  ? Icons.done_outlined 
                  : Icons.pending_outlined,
                  ),
              );
            },
            shrinkWrap: true,
            
          ),
        );
          },

        ),
      ),
      
    );
  }
}