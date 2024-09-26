import 'package:flutter/material.dart';
import '../../data/model/Task.dart';

class DialogAddOrUpdate extends StatefulWidget {
  final bool isUpdate;
  final Task? task;
  final Function addTask;

  const DialogAddOrUpdate({
    super.key,
    required this.addTask,
    required this.isUpdate,
    required this.task,
  });

  @override
  State<DialogAddOrUpdate> createState() => _DialogAddOrUpdateState();
}

class _DialogAddOrUpdateState extends State<DialogAddOrUpdate> {
  String _content = '';
  bool? _isStatus = false;
  TimeOfDay? _selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

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

    // Cập nhật checkBox
    _isStatus = widget.task?.status == 0;

    // Xử lý thời gian nếu có
    if (widget.task?.time != null) {
      _selectedTime = _parseTimeOfDay(widget.task!.time);
    }

    _content = widget.task?.content ?? '';
  }

  TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0].trim());
    final minute = int.parse(parts[1].trim());
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String title = widget.isUpdate ? 'Update Task' : 'Add Task';

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        height: size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              controller: _contentController,
              onChanged: (value) => setState(() {
                _content = value;
              }),
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
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
                  tristate: false,
                  activeColor: Colors.blue,
                  onChanged: _toggleCheckbox,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time: ${_selectedTime?.format(context) ?? "Not set"}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _selectTime(context),
                  child: const Icon(
                    Icons.timer,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_content.isEmpty) {
              print('Content is empty');
            } else {
              widget.addTask(
                widget.isUpdate
                    ? Task(
                        id: widget.task!.id,
                        content: _content,
                        time:
                            '${_selectedTime?.hour}:${_selectedTime?.minute}',
                        status: _isStatus! ? 0 : 1,
                      )
                    : Task(
                        id: null,
                        content: _content,
                        time:
                            '${_selectedTime?.hour}:${_selectedTime?.minute}',
                        status: _isStatus! ? 0 : 1,
                      ),
              );
              Navigator.pop(context, 'OK');
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
