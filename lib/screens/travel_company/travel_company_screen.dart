import 'package:flutter/material.dart';

class TravelCompanyScreen extends StatelessWidget {
  const TravelCompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Công ty du lịch')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Đây là màn Công ty du lịch', style: TextStyle(fontSize: 18)),
          // TODO: danh sách công ty, thêm/sửa/xóa…
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: tạo dialog Thêm công ty
        },
        child: const Icon(Icons.add_business),
      ),
    );
  }
}
