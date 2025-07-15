// lib/models/guide.dart

/// Trạng thái của hướng dẫn viên
enum GuideStatus { available, busy }

/// Model hướng dẫn viên
class Guide {
  final String id; // maHDV
  final String name; // tenHDV
  final DateTime birthDate; // ngaySinh
  final String identityNo; // soCCCD
  final String phone; // sdt
  final String address; // diaChi

  /// Lương theo ngày
  final double dailySalary;

  /// Số ngày đã làm (cần để tính lương cuối kỳ)
  int daysWorked;

  /// Trạng thái hiện tại
  GuideStatus status;

  Guide({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.identityNo,
    required this.phone,
    required this.address,
    required this.dailySalary,
    this.daysWorked = 0,
    this.status = GuideStatus.available,
  });
}
