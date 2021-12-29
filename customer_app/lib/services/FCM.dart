import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void>onBackgroundMessage(RemoteMessage message)async{
  if(message.data.containsKey('data')){
    final data=message.data['data'];
  }

  if(message.data.containsKey('notification')){
    final notification=message.data['notification'];
  }
}


class FCM{
  final streamCtrl=StreamController<String>.broadcast();
  final titleCtrl=StreamController<String>.broadcast();
  final bodyCtrl=StreamController<String>.broadcast();

  setNotifications(){
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    foregroundNotification();

    backgroundNotification();

    terminateNotification();
  }

  foregroundNotification(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      if(message.data.containsKey('data')){
        final data=message.data['data'];
      }

      if(message.data.containsKey('notification')){
        final notification=message.data['notification'];
      }

      titleCtrl.sink.add(message.notification!.title!);
      bodyCtrl.sink.add(message.notification!.body!);
    });
  }

  backgroundNotification(){
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      if(message.data.containsKey('data')){
        final data=message.data['data'];
      }

      if(message.data.containsKey('notification')){
        final notification=message.data['notification'];
      }

      titleCtrl.sink.add(message.notification!.title!);
      bodyCtrl.sink.add(message.notification!.body!);
    });
  }

  terminateNotification() async{
    RemoteMessage? initialMessage=
    await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage!=null){
      if(initialMessage.data.containsKey('data')){
        final data=initialMessage.data['data'];
      }

      if(initialMessage.data.containsKey('notification')){
        final notification=initialMessage.data['notification'];
      }

      titleCtrl.sink.add(initialMessage.notification!.title!);
      bodyCtrl.sink.add(initialMessage.notification!.body!);
    }
  }

  dispose(){
    streamCtrl.close();
    titleCtrl.close();
    bodyCtrl.close();
  }

}