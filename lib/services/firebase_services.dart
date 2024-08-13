import 'package:firebase_messaging/firebase_messaging.dart'; // nhan message
import 'package:firebase_notifications_flutter/main.dart';
import 'package:firebase_notifications_flutter/pages/screen_2.dart';
import 'package:firebase_notifications_flutter/services/notification_services.dart';
// show thong bao
import 'package:flutter/material.dart';

class FirebaseSevices {
  static String? token;
  // token firebase tra ve khi chay app lan dau, can gui cho backend

  static Future<void> init() async {
    await FirebaseMessaging.instance.getInitialMessage().then((value) {
      // khi tat app nhan duoc notifications, bam vao notifications se vao day
      // do he dieu hanh kiem soat
      print('[Log 😏] ${value?.notification}');
      if (value == null) return;
      // neu ko co dong nay khi mo app no se tu dong chuyen trang
      Navigator.of(MyApp.context!).push(
        MaterialPageRoute(
          builder: (_) {
            return const Screen2(vitri: 'khi tat app');
          },
        ),
      );
    });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      token = await FirebaseMessaging.instance.getToken();
      // token firebase cung cap cho may
      print(token);
    }

    // lang nghe o app khi co thong bao thi show len
    // goi tu phia NotificationServices
    FirebaseMessaging.onMessage
        .listen(NotificationServices.showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // khi dang o back ground app ma bam vao thong bao thi no se vao day
      // do thu vien firebase_messaging quyet dinh
      Navigator.of(MyApp.context!).push(
        MaterialPageRoute(
          builder: (_) {
            return const Screen2(vitri: 'back ground');
          },
        ),
      );
    });
  }
}
