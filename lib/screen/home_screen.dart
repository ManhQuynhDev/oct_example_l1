import 'package:flutter/material.dart';
import 'package:oct_exercise_l1/data/dao/task_dao.dart';
import 'package:oct_exercise_l1/screen/widget/dialog_widget.dart';
import '../../data/model/Task.dart';
import 'widget/task_item.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TimeOfDay? _selectedTime;
  List<Task> list = [];

  TaskDao taskDao = TaskDao();

  Future<void> _selectTime(BuildContext content) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: _selectedTime ?? TimeOfDay.now());

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _loadData() async {
    final tasks = await taskDao.getAllListData();
    setState(() {
      list = tasks;
    });
  }

  Future<void> insertData(Task task) async {
    await taskDao.insertData(task);
    _loadData();
  }

  Future<void> updateData(Task task) async {
    await taskDao.updateData(task);
    _loadData();
  }

  Future<void> deleteData(int id) async {
    await taskDao.deleteData(id);
    _loadData();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => DialogAddOrUpdate(
                              addTask: updateData,
                              isUpdate: true,
                              task: list[index]));
                    },
                    child: TaskItem(
                        task: list[index],
                        deleteTask: deleteData,
                        updateTask: updateData));
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => DialogAddOrUpdate(
                  addTask: insertData, isUpdate: false, task: null));
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // void updateTaskWork(Task updateTask) {
  //   print(updateTask.displayInfo());
  //   setState(() {
  //     int index = list.indexWhere((task) => task.id == updateTask.id);

  //     if (index != -1) {
  //       list[index] = updateTask;
  //     }
  //   });
  // }
}
