import 'package:flutter/material.dart';
// TODO: import model và provider khi bạn thêm List<Schedule> vào AppState

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final schedules = context.watch<AppState>().schedules;
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch chạy')),
      body: ListView.builder(
        itemCount: 0, // TODO thay bằng schedules.length
        itemBuilder: (_, i) {
          // final s = schedules[i];
          return ListTile(
            title: const Text('Chuyến #$i'),
            subtitle: const Text('... thông tin lịch ...'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    /* TODO */
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    /* TODO */
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* TODO thêm lịch */
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
