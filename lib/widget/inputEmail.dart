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
  InputField(
      {this.title,
      this.font,
      this.isPassword,
      this.controller,
      this.isEditable});
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter ${widget.title}';
            } else {
              switch (widget.title) {
                case "Email-id":
                  {
                    if (!isEmail(value!)) return 'Enter Valid Email';
                  }

                  break;
                   case "Mobile No." : 
                   {
                      if (value.length != 10)
                        return 'Mobile Number must be of 10 digit';
                    }
                  
                  break;
                default:
              }
            }
          },
          enabled: widget.isEditable,
          controller: widget.controller,
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
