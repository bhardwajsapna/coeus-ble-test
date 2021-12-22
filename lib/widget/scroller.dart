import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/utils/scroller_utils.dart';
import 'package:coeus_v1/widget/textLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPickerPage extends StatefulWidget {
  String title;
  double font;
  double width;
  List<String> values;
  int selectedIndex;
  ValueChanged<int> onChangedValue;

  CustomPickerPage(
      {required this.title,
      required this.values,
      required this.font,
      required this.width,
      required this.selectedIndex,
      required this.onChangedValue});

  @override
  CustomPickerPageState createState() => CustomPickerPageState();
}

class CustomPickerPageState extends State<CustomPickerPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Align(
            //   alignment: Alignment.centerRight,
            // child:
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: widget.font,
                        color: Constants.textPrimary,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            // ),
            buildCustomPicker(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
          ],
        ),
      );

  Widget buildCustomPicker() => Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: widget.width,
        child: CupertinoPicker(
          itemExtent: MediaQuery.of(context).size.height * 0.05,
          diameterRatio: 1.2,
          looping: true,
          scrollController:
              FixedExtentScrollController(initialItem: widget.selectedIndex),
          onSelectedItemChanged: (index) => setState(() {
            widget.selectedIndex = index;
            widget.onChangedValue(widget.selectedIndex);
          }),
          // selectionOverlay: Container(),
          // selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
          //   background: Colors.pink.withOpacity(0.12),
          // ),
          children: Utils.modelBuilder<String>(
            widget.values,
            (index, value) {
              final isSelected = widget.selectedIndex == index;
              final color = isSelected ? Colors.black : Constants.grey;

              return Center(
                child: Text(
                  value,
                  style: TextStyle(color: color, fontSize: 24),
                ),
              );
            },
          ),
        ),
      );
}
