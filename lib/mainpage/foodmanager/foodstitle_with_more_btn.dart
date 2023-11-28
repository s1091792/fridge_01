import 'package:flutter/material.dart';
import 'package:flutter_app_test/colors.dart';

class TitleWithMorebtn extends StatelessWidget {
  const TitleWithMorebtn({
    super.key, required this.title, required this.press, required this.color,
  });

  final String title;
  final Function() press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          TitleWithUnderline(text: title,color: color),
          const Spacer(),//放最右邊
          TextButton(
            onPressed: press,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  //框寬度 side: BorderSide(width: 3, color: Colors.black),
                ),
              ),
            ),
            //shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(20),
            //),
            //backgroundColor: kPrimaryColor,

            child: const Text(
              "more",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
class TitleWithUnderline extends StatelessWidget {
  const TitleWithUnderline({Key? key, required this.text, required this.color}) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding/4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: color,),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(right: kDefaultPadding/4),
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}