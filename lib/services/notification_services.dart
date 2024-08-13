import 'package:firebase_messaging/firebase_messaging.dart'; // nhan message
import 'package:firebase_notifications_flutter/main.dart';
import 'package:firebase_notifications_flutter/pages/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// cau hinh cho notifications

class NotificationServices {
  static late AndroidNotificationChannel channel;
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // khai bao mac dinh
  static Future<void> setupFlutterNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final settings = InitializationSettings(
        android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) {},
        ));

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // key trung voi AndroidManifest.xml
      'Hello ABC',
      description: 'My Description',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        // su kien an vao khi dang mo app
        // do thu vien flutter_local_notifications quyet dinh

        // Navigator.of(MyApp.context!).push(
        //   MaterialPageRoute(
        //     builder: (_) {
        //       return const Screen2(vitri: 'khi dang mo app');
        //     },
        //   ),
        // );

        // su dung thu vien webview_flutter de tu app co the vao web
        // thong qua web link
        Navigator.of(MyApp.context!).push(
          MaterialPageRoute(
            builder: (_) {
              return const WebViewExample(
                  webLink: 'https://www.youtube.com/watch?v=P7YERM-uqJY');
            },
          ),
        );
      },
    );
  }

  // hien thi thong bao: mau, icon
  // truyen vao message se co the hien thi duoc
  static void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id, // 'high_importance_channel'
            channel.name, // 'Hello ABC'
            channelDescription: channel.description,
            icon: "@mipmap/ic_launcher",
          ),
        ),
      );
    }
  }
}
