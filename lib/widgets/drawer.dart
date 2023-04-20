import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Cocktails'),
          ),
          ListTile(
            title: const Text('Favourite cocktails'),
            onTap: () {
              // Handle item 1
            },
          ),
        ],
      ),
    );
  }
}
