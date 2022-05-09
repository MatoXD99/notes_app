import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xff252525),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.note_add_outlined, color: Colors.white),
            label: const Text("All notes", style: TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.note_outlined, color: Colors.white),
            label: const Text("Old format notes", style: TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            label: const Text("Frequently used", style: TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined, color: Colors.white),
            label: const Text("Shared notebooks", style: TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.restore_from_trash_outlined, color: Colors.white),
            label: const Text("Recycle bin", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 30),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.folder, color: Colors.white),
            label: const Text("Folders", style: TextStyle(color: Colors.white)),
          ),
          OutlinedButton(
            onPressed: () {},
            child: const Text("Manage folders", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
