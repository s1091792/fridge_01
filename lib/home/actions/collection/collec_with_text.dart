// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'dart:core';
// import 'collection_page.dart';
//
//
// class getCo extends StatefulWidget {
//   getCo({
//     super.key,
//     required this.press
//   });
//   final Function() press;
//
//   @override
//   State<getCo> createState() => _getShState();
// }
//
// class _getShState extends State<getCo> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: double.maxFinite,
//       height: size.height,
//       child: ListView.builder(
//           itemCount: title.length,
//           scrollDirection: Axis.vertical,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               title: Text(
//                 '${title[index]}',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 30,
//                 ),
//               ),
//               onTap: () {
//                 print('${title[index]}');
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => RecipePage(
//                       title: '${title[index]}',
//                       text: '${text[index]}',
//                       imagepath: '${imagepath[index]}',
//                       step: '${step[index]}',
//                       liked: true, )));
//               },
//             );
//           }),
//     );
//   }
//
//
//
//
// }
//
