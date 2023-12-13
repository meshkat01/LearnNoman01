import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Model/note_model.dart';
import 'Screen/note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();
Hive.registerAdapter(NoteModelAdapter());
await Hive.openBox('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SafeArea(child: NoteScreen()),
    );
  }
}
