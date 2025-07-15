import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/contract.dart';
import '../../models/vehicle.dart';
import '../../models/driver.dart';
import '../../models/guide.dart';
import '../../providers/app_state.dart';

class ContractTripScreen extends StatelessWidget {
  const ContractTripScreen({super.key});

  /// Hiển thị Dialog tạo hợp đồng mới
  void _showCreateContractDialog(BuildContext context) {
    final appState = context.read<AppState>();

    // Giá trị tạm chọn trong dialog
    String? selectedVehicleId;
    String? selectedDriverId;
    String? selectedGuideId;
    DateTime? selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tạo hợp đồng chuyến đi'),
        content: StatefulBuilder(
          builder: (ctx, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Chọn ngày
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Ngày: ${selectedDate!.toLocal().toIso8601String().split('T').first}',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final d = await showDatePicker(
                        context: ctx,
                        initialDate: selectedDate!,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => selectedDate = d);
                    },
                  ),

                  // Dropdown chọn xe
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Chọn xe'),
                    items: appState.vehicles.map((v) {
                      return DropdownMenuItem(
                        value: v.id,
                        child: Text('Xe ${v.id} (${v.status.name})'),
                      );
                    }).toList(),
                    value: selectedVehicleId,
                    onChanged: (val) => setState(() => selectedVehicleId = val),
                  ),

                  // Dropdown chọn tài xế
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Chọn tài xế'),
                    items: appState.drivers.map((d) {
                      return DropdownMenuItem(
                        value: d.id,
                        child: Text('${d.name} (${d.status.name})'),
                      );
                    }).toList(),
                    value: selectedDriverId,
                    onChanged: (val) => setState(() => selectedDriverId = val),
                  ),

                  // Dropdown chọn HDV
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Chọn HDV'),
                    items: appState.guides.map((g) {
                      return DropdownMenuItem(
                        value: g.id,
                        child: Text('${g.name} (${g.status.name})'),
                      );
                    }).toList(),
                    value: selectedGuideId,
                    onChanged: (val) => setState(() => selectedGuideId = val),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              // Validate
              if (selectedVehicleId == null ||
                  selectedDriverId == null ||
                  selectedGuideId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng chọn đủ thông tin')),
                );
                return;
              }

              // Tạo object TripContract
              final newContract = TripContract(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                date: selectedDate!,
                vehicleId: selectedVehicleId!,
                driverId: selectedDriverId!,
                guideId: selectedGuideId!,
                status: ContractStatus.inProgress, // khởi tạo inProgress luôn
              );

              // Gọi provider để thêm và đổi trạng thái busy
              context.read<AppState>().createContract(newContract);

              Navigator.pop(context);
            },
            child: const Text('Tạo'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contracts = context.watch<AppState>().contracts;

    return Scaffold(
      appBar: AppBar(title: const Text('Hợp đồng chuyến đi')),
      body: ListView.separated(
        itemCount: contracts.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, i) {
          final c = contracts[i];
          return ListTile(
            title: Text('HĐ ${c.id} - ${c.status.name}'),
            subtitle: Text(
              'Ngày: ${c.date.toLocal().toIso8601String().split("T").first}\n'
              'Xe: ${c.vehicleId}, TX: ${c.driverId}, HDV: ${c.guideId}',
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Nút kết thúc chuyến
                IconButton(
                  icon: const Icon(Icons.check_circle_outline),
                  tooltip: 'Kết thúc chuyến',
                  color: c.status == ContractStatus.inProgress
                      ? Colors.green
                      : Colors.grey,
                  onPressed: c.status == ContractStatus.inProgress
                      ? () {
                          context.read<AppState>().endTrip(c.id);
                        }
                      : null,
                ),
                // Nút xóa hợp đồng
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    context.read<AppState>().contracts.removeAt(i);
                    context.read<AppState>().notifyListeners();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateContractDialog(context),
        tooltip: 'Tạo hợp đồng mới',
        child: const Icon(Icons.add_business),
      ),
    );
  }
}
