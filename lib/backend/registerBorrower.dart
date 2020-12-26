import 'package:cloud_firestore/cloud_firestore.dart';
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
          .whenComplete(() async {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          try {
            try {
              await _firestore.collection('data').doc(productId).set({
                'firstName': _firstNameController.text.toString(),
                'mobNum': widget.number.toString(),
                'address': _addressController.text.toString(),
                'itemName': productNameDropDownValue,
                'itemCat': productDropDownValue,
                'itemQuantity': _itemQuantityController.text.toString() +
                    ' ' +
                    quantityDropDownValue,
                'itemImage': userURL,
                'originalPrice': _originalPriceController.text.toString(),
                'discountPercent': _discountController.text.toString(),
                'negotiate': checkbox,
                'itemDescription': _itemDescController.text.toString(),
                'message': _messageController.text.toString(),
                'location': GeoPoint(userLat, userLong),
              }).catchError((e) {
                print(e);
              });
              await _firestore.collection('uniqueID').doc('lastId').update(
                  {'key': 'QW' + (productCode + 1).toString().padLeft(4, '0')});
              print('uploaded');
              Navigator.pushNamed(context, 'home');
            } on FirebaseException catch (e) {
              print(e.code);
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          } catch (e) {}
        } else {}
      }).catchError((e) {
        return 0;
      });
    } catch (e) {
      return 0;
    }
  } else {
    return 0;
  }
}
