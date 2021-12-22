import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/pages/newuser.page.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class InputField extends StatefulWidget {
  TextEditingController? controller;
  double? font;
  String? title;
  bool? isPassword;
  bool? isEditable = true;
  Function(String)? onChanged ;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  InputField(
      {this.title,
      this.font,
      this.isPassword,
      this.controller,
      this.isEditable,
      this.validator,
      this.onChanged,
      this.keyboardType
      });
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: widget.font! * 2,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          validator: widget.validator,
          enabled: widget.isEditable,
          onChanged: widget.onChanged,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          style: TextStyle(
            fontSize: 1 * widget.font!,
            color: Constants.textPrimary,
          ),
          obscureText: widget.isPassword!,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Constants.darkBlue)),
            fillColor: Constants.textPrimary,
            labelText: widget.title,
            labelStyle: TextStyle(
              color: Constants.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
