import 'package:coeus_v1/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Detailed_Card()))
        },
        child: Container(
          // margin: const EdgeInsets.only(right: 10.0),
          width: _width,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            shape: BoxShape.rectangle,
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: _width,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      // Icon and Hearbeat
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18, color: Constants.textDark),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Image(width: 40, height: 40, image: image),
                        ],
                      ),
                      (value != "")
                          ? Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w900,
                                        color: Constants.textDark,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      unit,
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Constants.textDark),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
