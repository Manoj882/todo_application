import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/models/todo_model.dart';
import '/utils/date_formatter.dart';
import '/widgets/general_botttom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.userId,{Key? key}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).textTheme.subtitle1!.fontFamily);
    print(Theme.of(context).textTheme.caption!.fontFamily);


    final fireStore = FirebaseFirestore.instance;
    final collection = fireStore.collection(TodoConstants.todo);
    // final stream = firestore.collection(TodoConstants.todo).doc('MwgsQop14nXbYUNRnngB');
    // stream.get().then((value) => log(value.data().toString()));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Application'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final todoName =
                  await GeneralButtomSheet().customBottomSheet(context);

              if (todoName != null) {
                final todoModel = TodoModel(todoName,userId);
                collection.add(todoModel.toMap());
              }
            },
            icon: const Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: basepadding,
        child: StreamBuilder(
          stream: collection.where("userId", isEqualTo: userId).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // print(snapshot.data!.docs.last.data());

            return SingleChildScrollView(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final queryDocSnapshot = snapshot.data!.docs[index];
                  final data = queryDocSnapshot.data()! as Map;
                  final todo = TodoModel.fromjson(data);
                  // print(data);
                  return Dismissible(
                    key: ValueKey(queryDocSnapshot.id),
                    onDismissed: (_){
                      queryDocSnapshot.reference.delete();
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.delete_outlined,
                        color: Colors.black54,
                        size: 30,
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        if (!todo.isCompleted) {
                          queryDocSnapshot.reference.update(
                            todo.updateStatus(),
                          );
                        }
                      },
                      title: Text(todo.title),
                      subtitle: Text(
                        DateFormatter.formatDateTime(todo.date),
                      ),
                      trailing: Icon(
                        todo.isCompleted
                            ? Icons.done_outlined
                            : Icons.pending_outlined,
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                primary: false,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: customSwitch(),
      
    );
  }
}

class customSwitch extends StatefulWidget {
  const customSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<customSwitch> createState() => _customSwitchState();
}

class _customSwitchState extends State<customSwitch> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Dark Mode"),
      trailing: Switch(
        value:  isDarkMode,
        onChanged: (value){
          isDarkMode = value;
          setState(() {
            
          });
        },
      ),
    );
  }
}
