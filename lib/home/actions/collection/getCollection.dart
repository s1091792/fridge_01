import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';

List<Map<String, dynamic>> colleData = []; // 食譜的 List


Future<Map<String, dynamic>> GetColle() async {
  print("進入收藏食譜2");
  final collection = FirebaseFirestore.instance.collection('recipes');
  final querySnapshot = await collection
      .where('liked', isEqualTo: true)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    print("進入收藏食譜3");

    final document = querySnapshot.docs[0].data();

    print(document);

    return {
      'title': document['recipe_name'] as String,
      'text': document['ingre_name'] as String,
      'imagepath': document['image'] as String,
      'step': document['context'] as String,
      'liked': document['liked'] as bool,
    };

  } else {
    print("進入收藏食譜no");
    return {};
  }
}
