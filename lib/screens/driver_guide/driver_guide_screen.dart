import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/driver.dart';
import '../../models/guide.dart';
import '../../providers/app_state.dart';

class DriverGuideScreen extends StatelessWidget {
  const DriverGuideScreen({super.key});

  void _showAddDialog(BuildContext context, bool isDriver) {
    final idCtl = TextEditingController();
    final nameCtl = TextEditingController();
    // ... thêm controllers cho các trường còn lại
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isDriver ? 'Thêm tài xế' : 'Thêm HDV'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: idCtl,
                decoration: const InputDecoration(labelText: 'Mã'),
              ),
              TextField(
                controller: nameCtl,
                decoration: const InputDecoration(labelText: 'Tên'),
              ),
              // TODO: các field khác như ngày sinh, CCCD, sđt, địa chỉ, lương…
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              final app = context.read<AppState>();
              if (isDriver) {
                app.drivers.add(
                  Driver(
                    id: idCtl.text,
                    name: nameCtl.text,
                    birthDate: DateTime.now(), // TODO parse
                    identityNo: '',
                    phone: '',
                    address: '',
                    baseSalary: 0,
                    salaryFactor: 1,
                  ),
                );
              } else {
                app.guides.add(
                  Guide(
                    id: idCtl.text,
                    name: nameCtl.text,
                    birthDate: DateTime.now(),
                    identityNo: '',
                    phone: '',
                    address: '',
                    dailySalary: 0,
                  ),
                );
              }
              app.notifyListeners();
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tài xế & HDV'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Tài xế'),
              Tab(text: 'Hướng dẫn viên'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList<Driver>(
              context: context,
              items: context.watch<AppState>().drivers,
              isDriver: true,
            ),
            _buildList<Guide>(
              context: context,
              items: context.watch<AppState>().guides,
              isDriver: false,
            ),
          ],
        ),
        floatingActionButton: Builder(
          builder: (ctx) {
            final tab = DefaultTabController.of(ctx)!.index;
            return FloatingActionButton(
              onPressed: () => _showAddDialog(ctx, tab == 0),
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  Widget _buildList<T>({
    required BuildContext context,
    required List<T> items,
    required bool isDriver,
  }) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, i) {
        final app = context.read<AppState>();
        if (isDriver) {
          final d = items[i] as Driver;
          return ListTile(
            title: Text(d.name),
            subtitle: Text('Trạng thái: ${d.status.name}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    /* tương tự edit */
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    app.drivers.removeAt(i);
                    app.notifyListeners();
                  },
                ),
              ],
            ),
          );
        } else {
          final g = items[i] as Guide;
          return ListTile(
            title: Text(g.name),
            subtitle: Text('Trạng thái: ${g.status.name}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    /* tương tự edit */
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    app.guides.removeAt(i);
                    app.notifyListeners();
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
