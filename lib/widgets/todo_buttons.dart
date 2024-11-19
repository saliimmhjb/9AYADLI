import 'package:flutter/material.dart';

class ToDoButtons extends StatelessWidget {
  final String buttonText;
  VoidCallback onPressed;

  ToDoButtons({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Text(buttonText, style: Theme.of(context).textTheme.overline!.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black54

      ),),
      color: Theme.of(context).primaryColor,
    );
  }
}
