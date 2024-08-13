import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notifications_flutter/services/firebase_services.dart';
import 'package:firebase_notifications_flutter/services/notification_services.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase
      .initializeApp(); // khoi tao firebase cua thu vien firebase_core
  // nghe FirebaseMessaging o che do nen, thu vien firebase_messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseSevices.init();
  // la services de hien thi len man hinh, thu vien firebase_notifications_flutter
  await NotificationServices.setupFlutterNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const HomePageA(),
    );
  }
}

class HomePageA extends StatefulWidget {
  const HomePageA({super.key});

  @override
  State<HomePageA> createState() => _HomePageAState();
}

class _HomePageAState extends State<HomePageA> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Home Page A 😍',
          style: TextStyle(color: Colors.orange, fontSize: 28.0),
        ),
      ),
    );
  }
}
