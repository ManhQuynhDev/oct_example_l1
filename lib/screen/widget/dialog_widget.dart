import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/model/Task.dart';

class DialogAddOrUpdate extends StatefulWidget {
  final bool isUpdate;

  final Task? task;

  final Function addTask;

  const DialogAddOrUpdate(
      {super.key,
      required this.addTask,
      required this.isUpdate,
      required this.task});

  @override
  State<DialogAddOrUpdate> createState() => _DialogAddOrUpdateState();
}

class _DialogAddOrUpdateState extends State<DialogAddOrUpdate> {
  String _content = '';
  bool? _isStatus = false;

  void _toggleCheckbox(bool? value) {
    setState(() {
      _isStatus = value ?? false;
    });
  }

  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(
      text: widget.isUpdate ? widget.task?.content : '',
    );
    _isStatus = widget.task?.status;

    setState(() {
      _content = (widget.isUpdate ? widget.task?.content : '')!;
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.isUpdate ? 'Update Task' : 'Add Task';
    return AlertDialog(
      title: Text(title),
      content: Container(
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: _contentController,
              onChanged: (value) => setState(() {
                _content = value;
              }),
              decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status Task',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Checkbox(
                    value: _isStatus,
                    tristate: true,
                    activeColor: Colors.blue,
                    onChanged: _toggleCheckbox)
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => {
            if (_content.isEmpty)
              {
                print('Empty')
              }
            else
              {
                widget.addTask(widget.isUpdate
                    ? Task(
                        widget.task!.id, 
                        _content,
                        DateTime.now(), 
                        _isStatus!, 
                      )
                    : Task(
                        Random().nextInt(100) + 50,
                        _content,
                        DateTime.now(),
                        _isStatus!,
                      )),
                Navigator.pop(
                    context, 'OK')
              }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
