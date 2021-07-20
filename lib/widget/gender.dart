import 'package:coeus_v1/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gender {
  String name;
  final ImageProvider icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}

class CustomRadio extends StatelessWidget {
  Gender _gender;

  CustomRadio(this._gender);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: _gender.isSelected ? Color(0xFF3B4257) : Colors.white,
        child: Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          margin: new EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Icon(
              //   _gender.icon,
              //   color: _gender.isSelected ? Colors.white : Colors.grey,
              //   size: 40,
              // ),
              Image(width: 20, height: 20, image: _gender.icon),
              SizedBox(height: 10),
              Text(
                _gender.name,
                style: TextStyle(
                    color: _gender.isSelected ? Colors.white : Colors.grey),
              )
            ],
          ),
        ));
  }
}

class GenderSelector extends StatefulWidget {
  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  List<Gender> genders = [];

  @override
  void initState() {
    super.initState();
    genders.add(new Gender("Male", AssetImage('assets/icons/male.png'), false));
    genders.add(new Gender(
        "Female", AssetImage('assets/icons/femaleUpdated.png'), false));
    genders.add(new Gender(
        "Others", AssetImage('assets/icons/transgender.png'), false));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          splashColor: Constants.darkBlue,
          onTap: () {
            setState(() {
              genders.forEach((gender) => gender.isSelected = false);
              genders[0].isSelected = true;
            });
          },
          child: CustomRadio(genders[0]),
        ),
        InkWell(
          splashColor: Constants.darkBlue,
          onTap: () {
            setState(() {
              genders.forEach((gender) => gender.isSelected = false);
              genders[1].isSelected = true;
            });
          },
          child: CustomRadio(genders[1]),
        ),
        InkWell(
          splashColor: Constants.darkBlue,
          onTap: () {
            setState(() {
              genders.forEach((gender) => gender.isSelected = false);
              genders[2].isSelected = true;
            });
          },
          child: CustomRadio(genders[2]),
        ),
      ],
    );

    // ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     shrinkWrap: true,
    //     itemCount: genders.length,
    //     itemBuilder: (context, index) {
    //       return InkWell(
    //         splashColor: Constants.darkBlue,
    //         onTap: () {
    //           setState(() {
    //             genders.forEach((gender) => gender.isSelected = false);
    //             genders[index].isSelected = true;
    //           });
    //         },
    //         child: CustomRadio(genders[index]),
    //       );
    //     });
  }
}
