import 'package:flutter/material.dart';

custombutton( F, btnText, context) {
  return SizedBox(
          width: MediaQuery.of(context).size.width*.7,

    child: ElevatedButton(
      onPressed: F,
      child: Text(btnText),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
      ),
    ),
  );
}
