import 'package:crowdgain/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:payup/utilities/constants.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    @required this.firstNameController,
    @required this.type,
    @required this.obscure,
    @required this.hint,
  });
  final TextEditingController firstNameController;
  final TextInputType type;
  final bool obscure;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: blackColor,
      ),
      cursorColor: mainTextColor,
      controller: firstNameController,
      keyboardType: type,
      maxLength: 50,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        filled: true,
        fillColor: cardColor,
        hintStyle: TextStyle(
          color: mainTextColor,
        ),
        counterText: '',
      ),
    );
  }
}
