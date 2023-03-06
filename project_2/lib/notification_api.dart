import 'package:flutter_local_notifications/flutter_local_notifications.dart';




class NotificationApi {

  static final _notifications  = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker'
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap-xxxhdpi/ic_launcher_foreground');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {},
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
}) async => _notifications.show(id, title, body, await _notificationDetails(), payload: payload);

}