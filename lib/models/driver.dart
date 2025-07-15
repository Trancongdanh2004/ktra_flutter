// lib/models/driver.dart

/// Trạng thái của tài xế
enum DriverStatus { available, busy }

/// Model tài xế
class Driver {
  final String id; // maTX
  final String name; // tenTX
  final DateTime birthDate; // ngaySinh
  final String identityNo; // soCCCD
  final String phone; // sdt
  final String address; // diaChi

  /// Lương cơ bản
  final double baseSalary;

  /// Hệ số lương
  final double salaryFactor;

  /// Trạng thái hiện tại
  DriverStatus status;

  Driver({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.identityNo,
    required this.phone,
    required this.address,
    required this.baseSalary,
    required this.salaryFactor,
    this.status = DriverStatus.available,
  });
}
