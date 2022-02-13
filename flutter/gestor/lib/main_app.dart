import 'package:flutter/material.dart';
import 'package:gestor/main_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      title: 'Optimus :: Gestor',
      home: const MainPage(),
    );
  }
}
