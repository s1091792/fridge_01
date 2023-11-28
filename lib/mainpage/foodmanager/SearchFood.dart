import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:intl/intl.dart';

List<Map<String, dynamic>> SfoodData = [];

// Future<Map<String, dynamic>> SearchFood(String foodName) async {
//   print("進入搜尋食材2");
//   final collection = FirebaseFirestore.instance.collection('food');
//   final querySnapshot = await collection
//       .where('food_name', isEqualTo: foodName)
//       .get();
//
//   if (querySnapshot.docs.isNotEmpty) {
//     print("進入搜尋食材3");
//
//     final document = querySnapshot.docs[0].data();
//
//     print(document);
//     Timestamp timestamp = document['EXP'] as Timestamp;
//     DateTime expDate = timestamp.toDate();
//     String formattedDate = DateFormat('yyyy-MM-dd').format(expDate);
//
//     return {
//       'title': document['food_name'] as String,
//       'date':  formattedDate,
//       'number': document['amount'] as int,
//       'image': document['image'] as String,
//     };
//   } else {
//     print("進入搜尋食譜no");
//     return {};
//   }
// }


// Stream<List<Map<String, dynamic>>> SearchFood(String foodName) async* {
Future<List<Map<String, dynamic>>> SearchFood(String foodName) async {
  try {
    SfoodData.clear();
    print('搜尋foodName：$foodName');

    var foodQuerySnapshot = await FirebaseFirestore.instance
        .collection('food')
        .where('food_name', isEqualTo: foodName)
        .get();
    print('進入搜尋食材3');

    if (foodQuerySnapshot.docs.isNotEmpty) {



      for (var foodDocument in foodQuerySnapshot.docs) {

        Timestamp timestamp = foodDocument['EXP'] as Timestamp;
        DateTime expDate = timestamp.toDate();
        String formattedDate = DateFormat('yyyy-MM-dd').format(expDate);

        var foodName = foodDocument['food_name'];
        var date = formattedDate;
        var number = foodDocument['amount'];
        var image = foodDocument['image'];

        SfoodData.add({
          'title': foodName as String,
          'date': date,
          'number': number as int,
          'image': image as String,
        });

        // print('進入篩選食材4');
      }
    } else {
      print('foodQuerySnapshot.docs is empty');
    }


    print('準備 yield 搜尋食材5：$SfoodData');
    // yield SfoodData.toList();
    return SfoodData.toList();
  } catch (e) {
    print('Error: $e');
    // yield [];
    return [];
  }
}
