import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todoList;
  final Function deleteTodo;
  const TodoList({required this.todoList, required this.deleteTodo, Key? key})
      : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

final collection = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('todos');

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Image.asset(
                    'assets/images/dog.png',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'No to-do added yet!',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          )
        : StreamBuilder<QuerySnapshot>(
            stream: collection.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  return Expanded(
                    child: ListView.builder(
                        itemCount: todoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              leading: Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                value: todoList[index].isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    todoList[index].isChecked = value as bool;
                                  });
                                },
                              ),
                              title: RichText(
                                text: TextSpan(
                                  text: todoList[index].title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      decoration: todoList[index].isChecked
                                          ? TextDecoration.lineThrough
                                          : null),
                                ),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    widget.deleteTodo(todoList[index].id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                          );
                        }),
                  );
              }
            });
  }
}
