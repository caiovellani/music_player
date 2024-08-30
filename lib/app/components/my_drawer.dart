import 'package:flutter/material.dart';

import '../ui/pages/switch_theme_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // home tile
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 24),
            child: ListTile(
              title: const Text('H O M E'),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),

          // settings tile
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 24),
            child: ListTile(
              title: const Text('SWITCH THEME'),
              leading: const Icon(Icons.settings_brightness),
              onTap: () {
                // pop drawer
                Navigator.pop(context);

                // navigate to settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SwitchThemePage()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
