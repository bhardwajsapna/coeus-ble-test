import 'package:coeus_v1/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detailsCardBar.dart';
import 'details_Card.dart';

class SummaryCard extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String value;
  final String unit;
  final Color color;

  SummaryCard({
    required this.title,
    required this.image,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double _width;
    if (value == "") {
      _width = 120;
    } else {
      _width = ((MediaQuery.of(context).size.width -
              (Constants.paddingSide * 2 + Constants.paddingSide / 2)) /
          2);
    }
    return InkWell(
      onTap: () => {
        if (this.title == 'Footsteps')
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailedCardBar(title: this.title)))
          }
        else
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detailed_Card(title: this.title)))
          }
      },
      child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          padding: EdgeInsets.all(15.0),
          width: _width,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            shape: BoxShape.rectangle,
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 22, color: Constants.textDark),
              ),
              Image(width: 40, height: 40, image: image),
              value == ""
                  ? SizedBox(
                      height: 0,
                      width: 0,
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Constants.textDark,
                          ),
                        ),
                        Text(
                          ' ' + unit,
                          style: TextStyle(
                              fontSize: 24, color: Constants.textDark),
                        ),
                      ],
                    ),
            ],
          )),
    );
  }
}
