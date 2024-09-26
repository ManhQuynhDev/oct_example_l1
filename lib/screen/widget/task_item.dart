import 'package:flutter/material.dart';

import '../../data/model/Task.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  final Function deleteTask;

  final Function updateTask;

  TaskItem(
      {required this.task, required this.deleteTask, required this.updateTask});

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    if (widget.task.status == 0) {
      _isDone = true;
    }
  }

  void _toggleCheckbox(bool? value) {
    setState(() {
      _isDone = value ?? false;
    });
    Task task = Task(
        id: widget.task.id,
        content: widget.task.content,
        time: widget.task.time,
        status: _isDone == true ? 0 : 1);
    widget.updateTask(task);
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 75,
      child: Card(
        color: Color(0xFF74b9ff),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                value: _isDone,
                onChanged: _toggleCheckbox,
                tristate: true,
                activeColor: Colors.blue,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.content,
                    style: TextStyle(
                        decoration: widget.task.status == 0
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: widget.task.status == 0
                            ? Colors.grey
                            : Colors.black,
                        fontSize: 18,
                        color: widget.task.status == 0
                            ? Colors.grey
                            : Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'deadline ${widget.task.time}',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  )
                ],
              )),
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
            if (widget.task.status == 0)
              {
                widget.task.status = 1,
                widget.deleteTask(widget.task.id),
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
