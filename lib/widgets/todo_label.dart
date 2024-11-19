import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class toDoLabel extends StatelessWidget {
  final String taskName;
  final bool taskCompeleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  toDoLabel(
      {super.key,
      required this.taskName,
      required this.taskCompeleted,
      required this.onChanged,
      required this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
            child: Row(
              children: [
                Checkbox(
                    value: taskCompeleted,
                    onChanged: onChanged,
                    activeColor: Theme.of(context).primaryColor,
                    fillColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor)),
                Expanded(
                  child: Text(
                    taskName,
                    style: Theme.of(context).textTheme.overline!.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      decoration: taskCompeleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => deleteTask?.call(context),
                  icon: Icon(Icons.close),
                  color: Colors.redAccent,
                  iconSize: 28,
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ]
      ),
    );
  }
}
