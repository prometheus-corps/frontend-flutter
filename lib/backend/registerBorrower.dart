import 'package:firebase_auth/firebase_auth.dart';

Future<int> registerBorrower(String name, String email, String username, int phoneNumber, String bankId, String password ) {
  final _auth = FirebaseAuth.instance;
  String detailedBody =
        ' Name: $name \n Email : $email \n Contact Number: $phoneNumber \n UserName: $username\n Bank Id: $bankId \n UserName: $username';
    if (await canLaunch(
            'mailto:info@qwings.in?subject=Register=New&body=$detailedBody%20plugin') &&
        studentName != '' &&
        parentMailId != '' &&
        parentName != '' &&
        parentnumber != '') {
      try {
       
      } catch (e) {
      return 0;
      }
    } else {
      return 0;
    }
  
}
