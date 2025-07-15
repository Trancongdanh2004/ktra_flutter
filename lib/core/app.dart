import 'package:flutter/material.dart';
import '../screens/main_scaffold/main_scaffold.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý xe du lịch',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScaffold(),
    );
  }
}
