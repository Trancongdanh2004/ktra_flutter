import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/vehicle.dart';
import '../../providers/app_state.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  void _showAddVehicleDialog(BuildContext context) {
    final idCtl = TextEditingController();
    final typeCtl = TextEditingController();
    final compCtl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thêm xe mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idCtl,
              decoration: const InputDecoration(labelText: 'Mã xe'),
            ),
            TextField(
              controller: typeCtl,
              decoration: const InputDecoration(labelText: 'Mã loại'),
            ),
            TextField(
              controller: compCtl,
              decoration: const InputDecoration(labelText: 'Mã công ty'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              final v = Vehicle(
                id: idCtl.text,
                typeId: typeCtl.text,
                companyId: compCtl.text,
              );
              context.read<AppState>().vehicles.add(v);
              context.read<AppState>().notifyListeners();
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _showEditVehicleDialog(BuildContext context, Vehicle v) {
    final typeCtl = TextEditingController(text: v.typeId);
    final compCtl = TextEditingController(text: v.companyId);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Chỉnh sửa xe'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Mã: ${v.id}'),
            TextField(
              controller: typeCtl,
              decoration: const InputDecoration(labelText: 'Mã loại'),
            ),
            TextField(
              controller: compCtl,
              decoration: const InputDecoration(labelText: 'Mã công ty'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              v.typeId = typeCtl.text;
              v.companyId = compCtl.text;
              context.read<AppState>().notifyListeners();
              Navigator.pop(context);
            },
            child: const Text('Cập nhật'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vehicles = context.watch<AppState>().vehicles;
    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách xe')),
      body: ListView.separated(
        itemCount: vehicles.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, i) {
          final v = vehicles[i];
          return ListTile(
            title: Text('Xe ${v.id}'),
            subtitle: Text(
              'Loại: ${v.typeId} – Công ty: ${v.companyId}\n'
              'Trạng thái: ${v.status.name}',
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditVehicleDialog(context, v),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<AppState>().vehicles.removeAt(i);
                    context.read<AppState>().notifyListeners();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddVehicleDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
