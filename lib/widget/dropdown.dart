import 'package:coeus_v1/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  List<String> dropdownItems = [];
  int selectedIndex;
  ValueChanged<String> onChangedValue;
  double font;
  DropDown(
      {required this.dropdownItems,
      required this.font,
      required this.selectedIndex,
      required this.onChangedValue});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  late List<DropdownMenuItem<String>> _dropdownMenuItems;
  late String _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(widget.dropdownItems);
    _selectedItem = _dropdownMenuItems[widget.selectedIndex].value!;
    print(widget.selectedIndex);
    print("selctedItem:" + _selectedItem.toString());
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = [];
    int index = 0;
    for (String listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem),
          value: listItem,
        ),
      );
      index = index + 1;
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 120,
      height: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          //color: Constants.lightBlue,
          border: Border.all(color: Constants.darkBlue)),
      child: DropdownButton<String>(
          value: _selectedItem,
          items: _dropdownMenuItems,
          onChanged: (value) {
            setState(() {
              _selectedItem = value!;
              widget.onChangedValue(_selectedItem);
              print("value changed:" + value);
            });
          }),
    );
  }
}
