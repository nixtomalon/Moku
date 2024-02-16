import 'package:flutter/material.dart';

class AppearanceSettingsPage extends StatefulWidget {
  const AppearanceSettingsPage({Key? key}) : super(key: key);

  @override
  State<AppearanceSettingsPage> createState() => _AppearanceSettingsPageState();
}

class _AppearanceSettingsPageState extends State<AppearanceSettingsPage> {
  int _selectedIndex = 0; // Default to 'System' theme

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Adjust the calculation to account for button spacing
    // Assuming 2 pixels of spacing between each button and 16.0 padding on each side
    final buttonWidth = (screenWidth - 32 - 4) / 3; // Subtracting 4 for the spacing

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 16), // Add some spacing
            ToggleButtons(
              constraints: BoxConstraints.expand(width: buttonWidth, height: 40), // Adjusted button size
              borderRadius: BorderRadius.circular(25.0), // Increased corner radius for more rounded corners
              isSelected: [0, 1, 2].map((index) => index == _selectedIndex).toList(),
              onPressed: (int index) {
                setState(() {
                  _selectedIndex = index;
                  _changeTheme(index);
                });
              },
              children: const [
                Text('System'),
                Text('Light'),
                Text('Dark'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _changeTheme(int index) {
    // Placeholder for theme change logic
    print('Switching to index: $index'); // Debugging purposes
    // Implement your theme switching logic here
  }
}
