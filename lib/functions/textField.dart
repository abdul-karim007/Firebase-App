import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

customTextField(context, cont, hint) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width*.7,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(border: UnderlineInputBorder(),fillColor: Colors.black, hintText: hint),
      )),
  );
}
