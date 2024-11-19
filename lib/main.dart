import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/widgets/todo_label.dart';

void main () async {
  await Hive.initFlutter();
  var box = await Hive.openBox("myBox");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "9ayadli",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF7879f1)),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFF7879f1),
        iconTheme: IconThemeData(color: Colors.white),
        fontFamily: GoogleFonts
            .poppins()
            .fontFamily,
        textTheme: GoogleFonts.poppinsTextTheme(),
        unselectedWidgetColor: Color(0xFF7879f1),
      ),
      home: HomeScreen()
    );
  }
}
