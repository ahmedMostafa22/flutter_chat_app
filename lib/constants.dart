import 'package:flutter/material.dart';

final kSendButtonTextStyle = TextStyle(
  color: Colors.teal[500],
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);
final kInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal[500], width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.teal[500], width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

final kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.teal[500], width: 2.0),
  ),
);
