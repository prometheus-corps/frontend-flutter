import 'package:firebase_auth/firebase_auth.dart';

Future<int> registerBorrower(String name, String) {
  final _auth = FirebaseAuth.instance;
  String detailedBody =
        'Student Name: $studentName \n Parent Name: $parentName \n Parent Contact Number: $parentnumber \n Class: $parentMailId';
    if (await canLaunch(
            'mailto:info@qwings.in?subject=Register=New&body=$detailedBody%20plugin') &&
        studentName != '' &&
        parentMailId != '' &&
        parentName != '' &&
        parentnumber != '') {
      try {
        await launch(
            'mailto:info@qwings.in?subject=Register=New&body=$detailedBody%20plugin');
      } catch (e) {
      return 0;
      }
    } else {
      return 0;
    }
  
}
