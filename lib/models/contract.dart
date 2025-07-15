// lib/models/contract.dart

/// Trạng thái hợp đồng chuyến đi
enum ContractStatus { scheduled, inProgress, completed }

/// Model hợp đồng chuyến đi
class TripContract {
  final String id; // maHopDong
  final DateTime date; // ngay tạo hợp đồng
  final String vehicleId; // soXe
  final String driverId; // maTX
  final String guideId; // maHDV

  /// Trạng thái hiện tại: chưa chạy / đang chạy / đã hoàn thành
  ContractStatus status;

  TripContract({
    required this.id,
    required this.date,
    required this.vehicleId,
    required this.driverId,
    required this.guideId,
    this.status = ContractStatus.scheduled,
  });
}
