import 'package:flutter/foundation.dart';
import '../models/vehicle.dart';
import '../models/driver.dart';
import '../models/guide.dart';
import '../models/contract.dart';

class AppState extends ChangeNotifier {
  List<Vehicle> vehicles = [];
  List<Driver> drivers = [];
  List<Guide> guides = [];
  List<TripContract> contracts = [];

  void createContract(TripContract c) {
    contracts.add(c);
    vehicles.firstWhere((v) => v.id == c.vehicleId).status = VehicleStatus.busy;
    drivers.firstWhere((d) => d.id == c.driverId).status = DriverStatus.busy;
    guides.firstWhere((g) => g.id == c.guideId).status = GuideStatus.busy;
    notifyListeners();
  }

  void endTrip(String contractId) {
    final c = contracts.firstWhere((c) => c.id == contractId);
    c.status = ContractStatus.completed;
    vehicles.firstWhere((v) => v.id == c.vehicleId).status =
        VehicleStatus.available;
    drivers.firstWhere((d) => d.id == c.driverId).status =
        DriverStatus.available;
    guides.firstWhere((g) => g.id == c.guideId).status = GuideStatus.available;
    notifyListeners();
  }
}
