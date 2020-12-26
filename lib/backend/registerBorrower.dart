import 'package:firebase_auth/firebase_auth.dart';

registerBorrower(String name, String email, String username, String phoneNumber,
    String bankId, String password) {
  FirebaseAuth auth = FirebaseAuth.instance;
  String detailedBody =
      ' Name: $name \n Email : $email \n Contact Number: $phoneNumber \n UserName: $username\n Bank Id: $bankId \n password: $password';
  print(detailedBody);
  if (phoneNumber.length == 10 &&
      name != '' &&
      email != '' &&
      password != '' &&
      bankId != '') {
    try {} catch (e) {
      return 0;
    }
  } else {
    return 0;
  }
}
