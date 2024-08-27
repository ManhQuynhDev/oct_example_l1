import 'package:flutter/material.dart';
import 'package:oct_exercise_l1/screen/widget/dialog_widget.dart';
import '../../data/model/Task.dart';
import 'widget/task_item.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  List<Task> list = [
    Task(1, 'Do homework', DateTime.now(), false),
    Task(2, 'Go to cinema', DateTime.now(), false),
    Task(3, 'Do homework', DateTime.now(), false),
    Task(4, 'Go to cinema', DateTime.now(), false),
    Task(5, 'Do homework', DateTime.now(), false),
    Task(6, 'Go to cinema', DateTime.now(), false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Todo List",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.blue),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      print(list[index].displayInfo());
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => DialogAddOrUpdate(
                              addTask: updateTaskWork,
                              isUpdate: true,
                              task: list[index]));
                    },
                    child: TaskItem(
                        task: list[index], deleteTask: deleteTaskWork));
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => DialogAddOrUpdate(
                  addTask: addTaskWork, isUpdate: false, task: null));
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  void addTaskWork(Task task) {
    setState(() {
      list.add(task);
    });
  }

  void updateTaskWork(Task updateTask) {
    print(updateTask.displayInfo());
    setState(() {
      int index = list.indexWhere((task) => task.id == updateTask.id);

      if (index != -1) {
        // Nếu tìm thấy, cập nhật task tại vị trí đó
        list[index] = updateTask;
      }
    });
  }

  void deleteTaskWork(Task task) {
    setState(() {
      list.removeWhere((t) => t.id == task.id);
    });
  }
}
