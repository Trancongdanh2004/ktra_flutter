import 'package:flutter/material.dart';

class SalaryStatsScreen extends StatelessWidget {
  const SalaryStatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thống kê lương')),
      body: Center(
        child: Text(
          'Giao diện Thống kê lương sẽ nằm ở đây',
          style: Theme.of(context).textTheme.titleLarge,

          ///head6
        ),
      ),
    );
  }
}
