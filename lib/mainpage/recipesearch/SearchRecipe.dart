import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../recipesearch/title_with_text.dart';
import 'dart:core';
import 'package:flutter_app_test/mainpage/components/main_category.dart';

List<Map<String, dynamic>> SerecipeData = []; // findRecipesStream
List<Map<String, dynamic>> SearchRecipeData = []; // SearchRecipe
List<Map<String, dynamic>> commentsData = [];


Stream<List<Map<String, dynamic>>> SearchRecipe(String recipeName) async* {
  try {
    SearchRecipeData.clear();
    print('搜尋recipeName：$recipeName');

    var recipeQuerySnapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .where('recipe_name', isEqualTo: recipeName)
        .get();
    print('進入篩選食材3');

    if (recipeQuerySnapshot.docs.isNotEmpty) {
      for (var recipeDocument in recipeQuerySnapshot.docs) {
        var text = recipeDocument['ingre_name'];
        var recipeName = recipeDocument['recipe_name'];
        var step = recipeDocument['context'];
        var liked = recipeDocument['liked'];
        var image = recipeDocument['image'];

        SearchRecipeData.add({
          'title': recipeName,
          'text': text,
          'imagepath': image,
          'step': step,
          'liked': liked,
        });

        // print('進入篩選食材4');
      }
    } else {
      print('recipeQuerySnapshot.docs is empty');
    }


    print('準備 yield 篩選食材5');
    yield SearchRecipeData.toList();
  } catch (e) {
    print('Error: $e');
    yield [];
  }
}
//////////

//將食譜的liked愛心存進資料庫
  void LikedRecipe(String documentId) async {
    final firestoreInstance = FirebaseFirestore.instance;

    CollectionReference recipesCollection = firestoreInstance.collection(
        'recipes');

    try {
      DocumentReference documentReference = recipesCollection.doc(documentId);

      await documentReference.update({'liked': true});

      print('$documentId 已liked');
    } catch (e) {
      print('更新 liked 出錯：$e');
    }
  }

  void UnLikedRecipe(String documentId) async {
    final firestoreInstance = FirebaseFirestore.instance;
    // 获取 recipes 集合的引用
    CollectionReference recipesCollection = firestoreInstance.collection(
        'recipes');

    try {
      // 获取指定文档的引用
      DocumentReference documentReference = recipesCollection.doc(documentId);

      // 更新文档的 liked 字段为 true
      await documentReference.update({'liked': false});

      print('$documentId 已unliked');
    } catch (e) {
      print('更新 unliked 出錯：$e');
    }
  }

  bool containsIngredient(String text, List<dynamic> otherNames) {
    for (var name in otherNames) {
      if (text.contains(name)) {
        // print('有找到相關食材食譜');
        return true;
      }
    }
    // print('no找到相關食材食譜');
    return false;
  }

  Stream<List<Map<String, dynamic>>> findRecipesStream(List<String> selectedIngredients) async* {
    try {
      SerecipeData.clear();

      for (var selectedIngredient in selectedIngredients) {
        var ingreQuerySnapshot = await FirebaseFirestore.instance
            .collection('ingres')
            .where('other_names', arrayContains: selectedIngredient)
            .get();

        if (ingreQuerySnapshot.docs.isNotEmpty) {
          var ingreDocument = ingreQuerySnapshot.docs[0];

          var otherNames = ingreDocument['other_names'] as List<dynamic>;

          var recipeQuerySnapshot = await FirebaseFirestore.instance
              .collection('recipes')
              .get();
          print('進入篩選食材3');

          if (recipeQuerySnapshot.docs.isNotEmpty) {
            for (var recipeDocument in recipeQuerySnapshot.docs) {
              var text = recipeDocument['ingre_name'];

              if (containsIngredient(text, otherNames)) {
                var recipeName = recipeDocument['recipe_name'];
                var step = recipeDocument['context'];
                var liked = recipeDocument['liked'];
                var image = recipeDocument['image'];

                SerecipeData.add({
                  'title': recipeName,
                  'text': text,
                  'imagepath': image,
                  'step': step,
                  'liked': liked,
                });
              }
              // print('進入篩選食材4');
            }
          } else {
            print('recipeQuerySnapshot.docs is empty');
          }
        }
      }

      print('準備 yield 篩選食材5');
      yield SerecipeData.toList();
    } catch (e) {
      print('Error: $e');
      yield [];
    }
  }

