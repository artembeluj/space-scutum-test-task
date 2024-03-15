import 'package:flutter/material.dart';

class AddHouseForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController floorsController;
  final Function(BuildContext) addHouseCallback;

  const AddHouseForm({super.key,
    required this.nameController,
    required this.floorsController,
    required this.addHouseCallback,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Add House',
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SizedBox(
        width: 321,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 16.0),
              child: Row(
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 30,
                      width: 147,
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'House Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 16.0),
              child: Row(
                children: [
                  const Text(
                    'Floors Count',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 70,
                    height: 30,
                    child: TextField(
                      controller: floorsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Count',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        int? floors = int.tryParse(value);
                        if (floors != null && floors > 100) {
                          floorsController.text = '100';
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Number of floors should be less than 100.'),
                            ),
                          );
                        }

                        if (floors != null && floors < 1) {
                          floorsController.text = '1';
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Number of floors should be more than 0.'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => addHouseCallback(context),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Container(
            width: 98,
            height: 24,
            alignment: Alignment.center,
            child: const Text('Add', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }
}
