import 'package:flutter/material.dart';
import 'package:flutter_app_test/colors.dart';
import 'package:flutter_app_test/login/components/square_tile.dart';

class SetButton extends StatelessWidget {
  final Function()? onTap;
  final String string;
  final String imagepath;

  const SetButton(
      {super.key,
      required this.onTap,
      required this.string,
      required this.imagepath});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.only(left: kDefaultPadding, top: 10, bottom: 10),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        /*decoration: BoxDecoration(
          color: Colors.grey[200],
          elevation: 0,
        ),*/
        child: Center(
          child: Row(
            children: <Widget>[
              Image.asset(imagepath),
              SizedBox(
                width: 20,
              ),
              Text(
                string,
                style: TextStyle(
                  //color: Colors.grey,
                  //fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
