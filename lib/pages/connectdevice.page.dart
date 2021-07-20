import 'package:flutter/material.dart';
import 'dart:async';

import 'package:grouped_list/grouped_list.dart';

List _elements = [
  {'name': 'device1', 'group': 'Devices'},
  {'name': 'device2', 'group': 'Devices'},
  {'name': 'device3', 'group': 'Devices'},
  {'name': 'device4', 'group': 'Devices'},
  {'name': 'device5', 'group': 'Devices'},
  {'name': 'device6', 'group': 'Devices'},
];

class ConnectDevice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GroupedListView<dynamic, String>(
      elements: _elements,
      groupBy: (element) => element['group'],
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, element) {
        return Card(
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Text(element['name']),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
        );
      },
    );
  }
}
