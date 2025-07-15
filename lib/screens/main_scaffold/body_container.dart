import 'package:flutter/material.dart';
import '../vehicle_list/vehicle_list_screen.dart';
import '../driver_guide/driver_guide_screen.dart';
import '../schedule/schedule_screen.dart';
import '../contract_trip/contract_trip_screen.dart';
import '../travel_company/travel_company_screen.dart';
import '../salary_stats/salary_stats_screen.dart';

class BodyContainer extends StatefulWidget {
  final int selectedIndex;
  const BodyContainer({required this.selectedIndex, super.key});
  @override
  State<BodyContainer> createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    // chỉ 4 tab con
    final tabs = [
      VehicleListScreen(),
      DriverGuideScreen(),
      ScheduleScreen(),
      ContractTripScreen(),
    ];
    // màn đơn giản không cần bottom nav
    if (widget.selectedIndex == 1) return const TravelCompanyScreen();
    if (widget.selectedIndex == 5) return const SalaryStatsScreen();

    return Scaffold(
      body: tabs[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: 'Xe',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'TX & HDV'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Lịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Hợp đồng',
          ),
        ],
        onTap: (i) => setState(() => _tabIndex = i),
      ),
    );
  }
}
