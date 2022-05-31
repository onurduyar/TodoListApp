import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/theme/colors.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({required this.addNewTodo, Key? key}) : super(key: key);
  final Function addNewTodo;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _taskController = TextEditingController();

  void _submitData() {
    final _taskName = _taskController.text;

    if (_taskName.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addNewTodo(_taskName, _selectedDate);
    Navigator.pop(context);
  }

  DateTime? _selectedDate;
  String dateText = 'Select a date.';
  @override
  Widget build(BuildContext context) {
    void _showdateTimepicker() {
      showDatePicker(
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                primary: primaryColor,
              )),
              child: child as Widget);
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2028),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
          dateText = DateFormat.yMd().format(_selectedDate!).toString();
        });
      });
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _taskController,
                decoration: const InputDecoration(labelText: 'Task'),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: dateText,
                    labelText: 'Due Date',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _showdateTimepicker();
                      },
                      icon: const Icon(Icons.date_range),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: _submitData,
                child: const Text('Add new task'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back to task list',
                    style: TextStyle(color: Colors.grey.shade600),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
