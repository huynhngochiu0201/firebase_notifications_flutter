import 'package:firebase_notifications_flutter/services/firebase_services.dart';
import 'package:firebase_notifications_flutter/services/notification_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    await FirebaseSevices.init();
    await NotificationServices.setupFlutterNotifications();
    // la services de hien thi len man hinh, thu vien firebase_notifications_flutter
    tokenController.text = FirebaseSevices.token ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Home Page 😍',
                  style: TextStyle(color: Colors.orange, fontSize: 28.0),
                ),
                TextField(
                  controller: tokenController,
                  decoration: const InputDecoration(border: InputBorder.none),
                  maxLines: 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
