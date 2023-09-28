import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: screenSize.width/6,right: screenSize.width/5,top: 10,bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Row(
        children:<Widget>[ 
          IconButton(
            onPressed:(){},
            icon: Image.asset(imagePath),
          ),
          Text(
            "    with google",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}