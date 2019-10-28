import 'package:flutter/material.dart';

showProcessingDialog(context, text) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.15,
                child:
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircularProgressIndicator(),
                  Text("    "),
                  Text(text,
                      style: TextStyle(
                          fontFamily: "OpenSans", color: Color(0xFF5B6978))),
                ])));
      });
}
