import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String text,
  required ToastStates state,
  double fontSize = 16,
  int seconds = 5,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  bool isPassword = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}


