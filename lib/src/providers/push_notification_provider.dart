import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // Para reaccionar a las notificaciones
  // Stream:
  final _menssageStreamController = StreamController<String>.broadcast();
  Stream<String> get messagesStream => _menssageStreamController.stream;


  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {

    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
  }

  initNotifications() async {
    // Pedimos permisos al usuario
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();
    print('=== FCM Token ===');
    print(token);
    // token: fIrBcc5CTsmyQHOmgWDbSZ:APA91bH94G-L4Ug6gOP_SmUoYdaCDewcjYv9BZxUaQST6Uaitor91itZrCjEvQ15atO4hobgv3duLAoprn-HYrCQNt-9i7LXwXPzF4Q8KyLSCHFo5raIVM1ln44EjHVZLQrHf-gTlYjD

    _firebaseMessaging.configure(
      onMessage:            onMessage,
      onBackgroundMessage:  onBackgroundMessage,
      onLaunch:             onLaunch,
      onResume:             onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print("==== onMessage ====");
    print("message: $message");
    // message: {notification: {title: Notificación de Prueba, body: Cuerpo de la notificación}, data: {nombre: Franz, uid: ABC123}}
    final nombre = message["data"]["nombre"] ?? 'no-data';
    // print('Nombre: $nombre');
    _menssageStreamController.sink.add(nombre);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print("==== onLaunch ====");
    print("message: $message");
    final nombre = message["data"]["nombre"] ?? 'no-data';
    _menssageStreamController.sink.add(nombre);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print("==== onResume ====");
    print("message: $message");
    // > message: {notification: {},
    // data: {uid: ABC123, collapse_key: com.franzcmarcelo.push_notifications,
    // google.original_priority: high, google.sent_time: 1601696737718,
    // google.delivered_priority: high, google.ttl: 2419200, from: 880177721418,
    // click_action: FLUTTER_NOTIFICATION_CLICK, nombre: Franz,
    // google.message_id: 0:1601696737728245%135fdbbd135fdbbd}}
    final nombre = message["data"]["nombre"] ?? 'no-data';
    // print('Nombre: $nombre');
    _menssageStreamController.sink.add(nombre);
  }

  dispose() {
    _menssageStreamController?.close();
  }

}

