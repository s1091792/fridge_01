import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:intl/intl.dart';

List<Map<String, dynamic>> SfoodData = [];

Future<Map<String, dynamic>> SearchFood(String foodName) async {
  print("進入搜尋食材2");
  final collection = FirebaseFirestore.instance.collection('food');
  final querySnapshot = await collection
      .where('food_name', isEqualTo: foodName)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    print("進入搜尋食材3");

    final document = querySnapshot.docs[0].data();

    print(document);
    Timestamp timestamp = document['EXP'] as Timestamp;
    DateTime expDate = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(expDate);

    return {
      'title': document['food_name'] as String,
      'date':  formattedDate,
      'number': document['amount'] as int,
      'image': document['image'] as String,
    };
  } else {
    print("進入搜尋食譜no");
    return {};
  }
}