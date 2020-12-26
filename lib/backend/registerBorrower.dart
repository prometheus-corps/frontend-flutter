import 'package:firebase_auth/firebase_auth.dart';

registerBorrower(String name, String email, String username, String phoneNumber,
    String bankId, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String detailedBody =
      ' Name: $name \n Email : $email \n Contact Number: $phoneNumber \n UserName: $username\n Bank Id: $bankId \n password: $password';
  print(detailedBody);
  if (phoneNumber.length == 10 &&
      name != '' &&
      email != '' &&
      password != '' &&
      bankId != '') {
    try {
      UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .whenComplete(() {})
          .catchError((e) {
        return 0;
      });
    } catch (e) {
      return 0;
    }
  } else {
    return 0;
  }
}
