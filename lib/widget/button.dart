import 'package:coeus_v1/pages/dashboard.page.dart';
import 'package:coeus_v1/utils/const.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  Function? onTapFunction;
  String? title;
  Widget? nextNavigation;
  double? width;
  Color? baseColor;

  Button(
      {this.onTapFunction,
      this.nextNavigation,
      this.title,
      this.width,
      this.baseColor});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          if (widget.onTapFunction != null) {
            widget.onTapFunction!();
          }
          if (widget.nextNavigation != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => widget.nextNavigation!));
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.07,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.baseColor != null
                ? widget.baseColor
                : Constants.lightBlue,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              // color: Constants.darkBlue,
              width: 1,
            ),
          ),
          child: Text(
            widget.title!,
            style: TextStyle(
              color: Constants.textDark,
              fontSize: MediaQuery.of(context).size.height * 0.027,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
