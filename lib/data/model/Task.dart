class Task {
  int? id;
  String content;
  String time;
  int status;

  Task(
      {required this.id,
      required this.content,
      required this.time,
      required this.status});

  String displayInfo() {
    return 'Task{_id: $id, _content: $content, _time: $time, _status: $status}';
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'content': content, 'time': time, 'status': status};
  }
}
