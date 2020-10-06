import 'package:flutter/material.dart';
import 'package:push_notifications/src/providers/push_notification_provider.dart';

import 'package:push_notifications/src/pages/home_page.dart';
import 'package:push_notifications/src/pages/message_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // Definimos una key o referencia que me permita mantener cuál es el estado actual del Navigator.
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();

    // Nos suscribirmos al stream
    pushProvider.messagesStream.listen((data) {
      navigatorKey.currentState.pushNamed('message', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': ( BuildContext context ) => HomePage(),
        'message': ( BuildContext context ) => MessagePage()
      },
    );
  }
}