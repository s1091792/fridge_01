import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String string;
  final String imagepath;

  const MyButton({super.key, required this.onTap, required this.string, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: screenSize.width,
        padding:  EdgeInsets.only(left: screenSize.width/8,right: screenSize.width/8,top: 10,bottom: 10),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(16),
          //color: Color(0xFFFFFFFF),
        ),
        child: Center(
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed:(){},
                icon: Image.asset(imagepath),
              ),
              SizedBox(width: 20,),
              Text(
                string,
                style: TextStyle(
                  //color: Colors.grey,
                  fontWeight: FontWeight.bold,
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