import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const AppDrawer({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      'Danh sách xe',
      'Công ty du lịch',
      'Tài xế',
      'Hướng dẫn viên',
      'Hợp đồng chuyến đi',
      'Thống kê lương',
    ];
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Menu')),
          for (var i = 0; i < items.length; i++)
            ListTile(
              title: Text(items[i]),
              selected: i == selectedIndex,
              onTap: () => onTap(i),
            ),
        ],
      ),
    );
  }
}
