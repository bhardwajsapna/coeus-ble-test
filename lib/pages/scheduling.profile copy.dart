
import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/widget/scroller.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/textLogin.dart';


class SchedulingProfilePage extends StatefulWidget {
  @override
  _SchedulingProfilePageState createState() => _SchedulingProfilePageState();
}

class _SchedulingProfilePageState extends State<SchedulingProfilePage> {

  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    
    final elements =[3,6,8];
    int selectedIndex = 0;

    List<Widget> _buildItems() {
    return elements
        .map((val) => MySelectionItem(
              title: val.toString(),
            ))
        .toList();
  }

  List<Widget> _buildTimers(count) {
    List<Widget> li=[];
    for(var i=0;i<count;i++){
      li.add(TextWrapper(textstr: "Hi",font:44));
    }
    return li;
  }

    return  Scaffold(
      body: Column(
      children: [
        SizedBox(height: 50,),
        TextWrapper(textstr:"Monitoring Scheduler",font: 32,),
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          // _buildTimers(elements[selectedIndex])
          [
            TextWrapper(textstr:"Scheduling Frequency",font: 24,),
            Container(
                child: DirectSelect(
                              itemExtent: 35.0,
                              selectedIndex: selectedIndex,
                              child: MySelectionItem(
                                isForList: false,
                                title: elements[selectedIndex].toString(),
                              ),
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  selectedIndex = index!;
                                });
                              },
                              items: _buildItems()),
              ),
            Container(
              height:300,
              child: ListView.builder(
                itemCount: elements[selectedIndex],
                itemBuilder: (context, index) {
                  return Container(
                    height:100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Constants.white, Constants.lightBlue]),
                    ),
                  );
                },
              ),
            )
              
          ],
        ),
      ],
    )
    );
  }
}
//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({required this.title, this.isForList = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}