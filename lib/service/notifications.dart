import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:mymemo/model/person-model.dart' as ps;

class BirthdayNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MethodChannel platform =
  MethodChannel('dexterx.dev/flutter_local_notifications_example');

  init() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var andriod = new AndroidInitializationSettings("@mipmap/ic_launcher");
    var ios = new IOSInitializationSettings();
    var seting = new InitializationSettings(android: andriod, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(seting);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String currentTimeZone =
    await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  Future<void> ScheduledBirthDateNotification(ps.Person person) async {
    _configureLocalTimeZone();
    init();
    DateTime dateTime=DateTime.parse(person.birthDate);
    int y=DateTime.now().year;
    AndroidNotificationDetails androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      'repeating description',
      tag: "tag$person.id",
    );
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    if(DateTime.now().month>dateTime.month  ||(DateTime.now().month==dateTime.month && DateTime.now().day>dateTime.day) )
      y++;

    await flutterLocalNotificationsPlugin.zonedSchedule(
        person.id,
        'scheduled title Date',
        'scheduled body',
        tz.TZDateTime(tz.local, y, dateTime.month, dateTime.day, 12, 00),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> intiScheduledNotification() async {
    _configureLocalTimeZone();
    init();
   // DateTime dateTime=DateTime.parse(person.birthDate);
    // var scheduledNotificationDateTime = new DateTime.now().add(new Duration(seconds: 60));

    AndroidNotificationDetails androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      'repeating description',
    );
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
    1,
    'scheduled title Date 1',
    'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 60)),
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        3,
        'scheduled title Date 3',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 120)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'scheduled title Date 2',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 90)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<List> getPendingNotifications() async {
    init();
    List id=[];
    List<PendingNotificationRequest> list = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (int i = 0; i < list.length; i++) {
    id.add(list[i].id);
    print(id[i].toString() + "from list $i");
    }
    return id;
  }

  Future<void> cancelNotificationWithid(int id) async {
    init();
    print("cancel");
    await flutterLocalNotificationsPlugin.cancel(id,tag: "tag$id");
  }


}
