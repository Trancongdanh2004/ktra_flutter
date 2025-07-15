enum VehicleStatus { available, busy }

class Vehicle {
  final String id;
  final String typeId;
  final String companyId;
  VehicleStatus status;
  Vehicle({
    required this.id,
    required this.typeId,
    required this.companyId,
    this.status = VehicleStatus.available,
  });
}
