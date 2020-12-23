import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getFCMToken() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.configure();
  String tokenKey = '';
  print('Token as :');
  await _firebaseMessaging.getToken().then((String token) {
    assert(token != null);
    tokenKey = token;
  });
  print(tokenKey);
  return (tokenKey);
}
