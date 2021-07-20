import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/widget/scroller.dart';
import 'package:coeus_v1/widget/time_picker.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/textLogin.dart';

final key = new GlobalKey<CustomPickerPageState>();

class SchedulingProfilePage extends StatefulWidget {
  @override
  _SchedulingProfilePageState createState() => _SchedulingProfilePageState();
}

class _SchedulingProfilePageState extends State<SchedulingProfilePage> {
  final ScrollController _scrollController = new ScrollController();
  late CustomPickerPage custom_picker;
  final elements = [1, 2, 3, 4, 5, 6];
  int selected_index = 3;
  @override
  Widget build(BuildContext context) {
    var currentState = key.currentState;
    List<String> elements_str = elements.map((e) => e.toString()).toList();
    return Scaffold(
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height - 50,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomLeft,
          //       colors: [Constants.white, Constants.lightBlue]),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: CustomPickerPage(
                    font: 22,
                    width: 150,
                    title: "Readings per day ",
                    values: elements_str,
                    selectedIndex: selected_index,
                    onChangedValue: (index) =>
                        setState(() => this.selected_index = index)),
              ),
              Container(
                height: 600,
                child: ListView.builder(
                  itemCount: elements[selected_index],
                  itemBuilder: (context, index) {
                    return TimePickerWidget();
                  },
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
