class Task {
  int _id;
  String _content;
  DateTime _time;
  bool _status;

  Task(this._id, this._content, this._time, this._status);

  bool get status => _status;

  set status(bool value) {
    _status = value;
  }

  DateTime get time => _time;

  set time(DateTime value) {
    _time = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String displayInfo() {
    return 'Task{_id: $_id, _content: $_content, _time: $_time, _status: $_status}';
  }
}
