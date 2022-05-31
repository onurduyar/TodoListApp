import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/models/date_format.dart';
import 'package:todolist_app/models/todo.dart';
import 'package:todolist_app/screens/introduction_screen.dart';
import 'package:todolist_app/widgets/homepage/add_new_todo.dart';
import 'package:todolist_app/widgets/homepage/todo_list.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

final _auth = firebase_auth.FirebaseAuth.instance;
late firebase_auth.User loggedUser;
final DateTime today = DateTime.now();
var mon = today.month;
final String todayDate = DateFormat.d().format(DateTime.now()).toString();

class _HomePageState extends State<HomePage> {
  final String? username =
      firebase_auth.FirebaseAuth.instance.currentUser!.email;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              child: CircleAvatar(
                child: Text(
                  username![0],
                  style: const TextStyle(fontSize: 45, color: Colors.white),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              username!,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const IntroductionScreen())));
              },
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Log out'),
            ),
          ],
        )),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          dateFormatter(DateTime.now()),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          'Your tasks for the week',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  TodoList(
                    todoList: todoList,
                    deleteTodo: _deleteTodoItem,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            _startAddNewTodo(context);
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }

  void _addNewTodo(String title, DateTime date) async {
    final DateTime dateTimeNow = DateTime.now();
    final newTodo = Todo(id: dateTimeNow.toString(), title: title, date: date);
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(dateTimeNow.toString())
        .set({
      'id': newTodo.id,
      'title': newTodo.title,
      'date': newTodo.date,
      'isChecked': newTodo.isChecked,
    });
    setState(() {
      todoList.add(newTodo);
    });
  }

  void _deleteTodoItem(String id) async {
    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('todos')
        .doc(id);
    await docTodo.delete();
    setState(() {
      todoList.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _startAddNewTodo(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: ctx,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              child: NewTodo(
                addNewTodo: _addNewTodo,
              ),
            ),
          );
        });
  }
}
