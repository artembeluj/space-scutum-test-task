import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_task/core/database_helper.dart';

const MethodChannel _channel = MethodChannel('com.example.myapp/channel');

Future<void> _startBackgroundNotifications(String message) async {
  await _channel.invokeMethod('startBackgroundNotifications', {'message': message});
}

class FloorListPage extends StatefulWidget {
  final String houseName;
  final int numberOfFloors;

  const FloorListPage({
    super.key,
    required this.houseName,
    required this.numberOfFloors,
  });

  @override
  _FloorListPageState createState() => _FloorListPageState();
}

class _FloorListPageState extends State<FloorListPage> {
  int selectedFloor = 0;
  int elevatorFloor = 1;

  Timer? elevatorTimer;
  Timer? notificationTimer;

  bool isElevatorMoving = false;

  late DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper.instance;
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _startBackgroundNotifications('Current floor: ${elevatorFloor.toString()}');
    });
  }

  @override
  void dispose() {
    elevatorTimer?.cancel();
    notificationTimer?.cancel();
    super.dispose();
  }

  void _startElevator(int destinationFloor) {
    elevatorTimer?.cancel();

    elevatorTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (elevatorFloor < destinationFloor) {
        setState(() {
          elevatorFloor++;
        });
      } else if (elevatorFloor > destinationFloor) {
        setState(() {
          elevatorFloor--;
        });
      } else {
        _stopElevator();
      }
    });
  }

  void _stopElevator() {
    elevatorTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 150),
          Container(
            padding: const EdgeInsets.only(left: 30),
            color: Colors.white,
            child: const Text(
              'Floors',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              height: 2,
              color: Colors.black,
              width: 400,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.numberOfFloors,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final floorNumber = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFloor = floorNumber;
                        _startElevator(selectedFloor);
                        isElevatorMoving = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selectedFloor == floorNumber
                            ? Colors.yellow
                            : elevatorFloor == floorNumber
                            ? Colors.green
                            : null,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          'Floor $floorNumber',
                          style: TextStyle(
                            color: selectedFloor == floorNumber ? Colors.black : null,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          children: [
            Text(
              'Designed by Artem Bielov',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}