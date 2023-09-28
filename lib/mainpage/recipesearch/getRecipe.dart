import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';

List<Map<String, dynamic>> recipeData = []; // 食譜的 List


StreamBuilder<QuerySnapshot> getRecipe() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('recipes')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );
      final int recipeCount = snapshot.data!.docs.length;


      // 將留言資料保存到 commentsData 中
      recipeData = snapshot.data!.docs.map((document) {

        return {
          'title': document['recipe_name'] as String,
          'text': document['ingre_name'] as String,
          'imagepath': document['image'] as String,
          'step': document['context'] as String,
        };


        // }).whereType<Map<String, dynamic>>().toList();
      }).toList();
      //print(recipeData);
      print("成功抓到食譜");

      if (recipeCount > 0) {
        // 這裡不再回傳 Widget，只回傳一個空的 Container
        return Container();
      } else {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          child: Text(
            'no recipe...',
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    },
  );
}


