import 'package:flutter/material.dart';
import 'package:test_task/pages/house_list_page.dart';
import 'package:test_task/shared/constants/constants.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  void _navigateToHouseList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HouseListPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppConstants.mainPageTitle,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Image(
              image: AssetImage('assets/main_image.jpg'),
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _navigateToHouseList(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(228, 57),
              ),
              child: const Text(AppConstants.buttonText),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              AppConstants.bottomBarText,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}