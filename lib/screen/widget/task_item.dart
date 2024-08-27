import 'package:flutter/material.dart';

import '../../data/model/Task.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  final Function deleteTask;

  TaskItem({required this.task, required this.deleteTask});

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  void initState() {
    super.initState();
  }

  void _toggleCheckbox(bool? value) {
    setState(() {
      widget.task.status = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      child: Card(
        color: Color(0xFF74b9ff),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                value: widget.task.status,
                onChanged: _toggleCheckbox,
                tristate: true,
                activeColor: Colors.blue,
              ),
              Expanded(
                child: Text(
                  widget.task.content,
                  style: TextStyle(
                      decoration: widget.task.status
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor:
                          widget.task.status ? Colors.grey : Colors.black,
                      fontSize: 16,
                      color: widget.task.status ? Colors.grey : Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 25,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => _showDialogConfirm(context),
    );
  }

  AlertDialog _showDialogConfirm(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Task"),
      content: Text('Do you want delete task ${widget.task.content}'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => {
            if (widget.task.status == true)
              {
                widget.task.status = false,
                widget.deleteTask(widget.task),
                Navigator.pop(context)
              }
            else
              {Navigator.pop(context), _showDialogWarning(context)}
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}

void _showDialogWarning(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: const Icon(Icons.warning_rounded,
            color: Color.fromARGB(255, 22, 22, 22)),
        title: const Text('Warning'),
        content:
            const Text('This is task don\'t finish please complete this task'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Close'),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
