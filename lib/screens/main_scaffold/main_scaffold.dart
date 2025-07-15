import 'package:flutter/material.dart';
import '../../widgets/app_drawer.dart';
import 'body_container.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _drawerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý xe du lịch')),
      drawer: AppDrawer(
        selectedIndex: _drawerIndex,
        onTap: (i) {
          setState(() => _drawerIndex = i);
          Navigator.pop(context);
        },
      ),
      body: BodyContainer(selectedIndex: _drawerIndex),
    );
  }
}
