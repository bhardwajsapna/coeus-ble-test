import 'package:coeus_v1/utils/const.dart';
import 'package:flutter/material.dart';

class TextWrapper extends StatefulWidget {
  String? textstr;
  double? font;
  TextWrapper({this.textstr, this.font});
  @override
  _TextWrapperState createState() => _TextWrapperState();
}

class _TextWrapperState extends State<TextWrapper> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Container(
        //color: Colors.green,
        child: Center(
          child: Text(
            widget.textstr!,
            style: TextStyle(
                fontSize: widget.font,
                color: Constants.textPrimary,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
