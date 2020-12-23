import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getFCMToken() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.configure();
  String tokenKey = '';
  await _firebaseMessaging.getToken().then((String token) {
    assert(token != null);
    tokenKey = token;
  });
  return (tokenKey);
}
