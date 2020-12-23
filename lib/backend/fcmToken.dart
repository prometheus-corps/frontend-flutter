import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getFCMToken() async {
  FirebaseMessaging.getInstance().getToken()
    .addOnCompleteListener(new OnCompleteListener<String>() {
        @Override
        public void onComplete(@NonNull Task<String> task) {
          if (!task.isSuccessful()) {
            Log.w(TAG, "Fetching FCM registration token failed", task.getException());
            return;
          }

          // Get new FCM registration token
          String token = task.getResult();

          // Log and toast
          String msg = getString(R.string.msg_token_fmt, token);
          Log.d(TAG, msg);
          Toast.makeText(MainActivity.this, msg, Toast.LENGTH_SHORT).show();
        }
    });
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
