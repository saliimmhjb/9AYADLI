import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/database.dart';
import 'package:todoapp/screens/about_kayadli.dart';
import 'package:todoapp/widgets/todo_buttons.dart';
import 'package:todoapp/widgets/todo_label.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _myBox = Hive.box("myBox");

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createIntialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  toDoDatabase db = toDoDatabase();

  final newTaskController = TextEditingController();



  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
          content: Container(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: newTaskController,
                  style: Theme.of(context).textTheme.overline!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    hintText: "Add new task ..",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ToDoButtons(buttonText: "Save", onPressed: SaveNewTask),
                    const SizedBox(width: 8,),
                    ToDoButtons(buttonText: "Cancel", onPressed:() => Navigator.of(context).pop(),)
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    db.updateData();
  }

  void SaveNewTask()
  {
    if (newTaskController.text.isNotEmpty) {
      setState(() {
        db.toDoList.add([newTaskController.text, false]);
        newTaskController.clear();
      });
      Navigator.of(context).pop();
      db.updateData();
    }



  }
  void deleteTask(int index)
  {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => AboutKayadli(),
            ),
          ),
          child: Text(
            "9AYADL!",
            style: Theme.of(context).textTheme.overline!.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 65,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Color(0xFF7879f1),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return toDoLabel(
                taskName: db.toDoList[index][0],
                taskCompeleted: db.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteTask: (context) => deleteTask(index),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 5.0,
              decoration: BoxDecoration(
                gradient:LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white,
                    ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
