import 'package:flutter/material.dart';

class ForceUpdateDialog {
  static void show(BuildContext context, {required String updateUrl}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Update Required'),
        content: const Text('A new version of the app is available. Please update to continue.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Open update URL (e.g., Play Store)
              // You can use url_launcher here
              Navigator.of(context).pop();
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }
}
