import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../recipesearch/title_with_text.dart';
import 'dart:core';

List<Map<String, dynamic>> SrecipeData = []; // 食譜的 List

// StreamBuilder<QuerySnapshot> SearchRecipe(String recipeName) {
//   return StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance
//         .collection('recipes')
//         .where('recipe_name', isEqualTo: recipeName)
//         .snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (!snapshot.hasData)
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       final int recipeCount = snapshot.data!.docs.length;
//       print("進入搜尋食譜");
//
//
//       // 將留言資料保存到 commentsData 中
//       SrecipeData = snapshot.data!.docs.map((document) {
//
//         return {
//           'title': document['recipe_name'] as String,
//           'text': document['ingre_name'] as String,
//           'imagepath': document['image'] as String,
//           'step': document['context'] as String,
//         };
//
//
//         // }).whereType<Map<String, dynamic>>().toList();
//       }).toList();
//       print(SrecipeData);
//       print("成功抓到搜尋食譜：$recipeName");
//
//       if (recipeCount > 0) {
//         // 這裡不再回傳 Widget，只回傳一個空的 Container
//         return Container();
//       } else {
//         return Container(
//           padding: EdgeInsets.symmetric(vertical: 10.0),
//           alignment: Alignment.center,
//           child: Text(
//             'no recipe...',
//             style: TextStyle(fontSize: 20),
//           ),
//         );
//       }
//     },
//   );
// }


// Future<void> searchAndDisplayRecipes(String recipeName, Size size) async {
//   print("進入搜尋食譜1");
//   await SearchRecipe(recipeName);
//
//   recipe_title_text(
//     size: size,
//     title: SrecipeData.map((recipe) => recipe['title'] as String).toList(),
//     text: SrecipeData.map((recipe) => recipe['text'] as String).toList(),
//     imagepath: SrecipeData.map((recipe) => recipe['imagepath'] as String).toList(),
//     step: SrecipeData.map((recipe) => recipe['step'] as String).toList(),
//     press: () {},
//     liked: [false, false, false, false],
//   );
// }
//
// Future<void> SearchRecipe(String recipeName) async {
//
//     print("進入搜尋食譜2");
//     FirebaseFirestore.instance
//         .collection('recipes')
//         .where('recipe_name', isEqualTo: recipeName)
//         .snapshots();
//     print("進入搜尋食譜3");
//     (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (!snapshot.hasData)
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       final int recipeCount = snapshot.data!.docs.length;
//       print("進入搜尋食譜4");
//
//
//       // 將留言資料保存到 commentsData 中
//       SrecipeData = snapshot.data!.docs.map((document) {
//
//         return {
//           'title': document['recipe_name'] as String,
//           'text': document['ingre_name'] as String,
//           'imagepath': document['image'] as String,
//           'step': document['context'] as String,
//         };
//
//       }).toList();
//       print(SrecipeData);
//       print("成功抓到搜尋食譜：$recipeName");
//
//       if (recipeCount > 0) {
//         // 這裡不再回傳 Widget，只回傳一個空的 Container
//         return Container();
//       } else {
//         return Container(
//           padding: EdgeInsets.symmetric(vertical: 10.0),
//           alignment: Alignment.center,
//           child: Text(
//             'no recipe...',
//             style: TextStyle(fontSize: 20),
//           ),
//         );
//       }
//     };
//
// }
List<Map<String, dynamic>> SerecipeData = []; // 食譜的 List

Future<Map<String, String>> SearchRecipe(String recipeName) async {
  // print("進入搜尋食譜2");
  final collection = FirebaseFirestore.instance.collection('recipes');
  final querySnapshot = await collection
      .where('recipe_name', isEqualTo: recipeName)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    // print("進入搜尋食譜3");

    final document = querySnapshot.docs[0].data();

    print(document);

    return {
      'title': document['recipe_name'] as String,
      'text': document['ingre_name'] as String,
      'imagepath': document['image'] as String,
      'step': document['context'] as String,
    };

  } else {
    print("進入搜尋食譜no");
    return {};
  }
}

//將食譜的liked愛心存進資料庫
void LikedRecipe(String documentId) async {
  final firestoreInstance = FirebaseFirestore.instance;

  CollectionReference recipesCollection = firestoreInstance.collection('recipes');

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
  CollectionReference recipesCollection = firestoreInstance.collection('recipes');

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


Future<List<Map<String, dynamic>>> findRecipesByIngredient(List<String> selectedIngredients) async {
  try {

    print('進入篩選食材2');
    List<Map<String, dynamic>> recipes = [];

    for (var selectedIngredient in selectedIngredients) {
      var ingreQuerySnapshot = await FirebaseFirestore.instance
          .collection('ingres')
          .where('ingre_name', isEqualTo: selectedIngredient)
          .get();

      if (ingreQuerySnapshot.docs.isNotEmpty) {
        var ingreDocument = ingreQuerySnapshot.docs[0];

        var otherNames = ingreDocument['other_names'] as List<dynamic>;

        var recipeQuerySnapshot = await FirebaseFirestore.instance
            .collection('recipes')
            .get();
        print('進入篩選食材3');

        if (recipeQuerySnapshot.docs.isNotEmpty) {
          recipeQuerySnapshot.docs.forEach((recipeDocument) {
            // print('recipeDocument:$recipeDocument');
            var text = recipeDocument['ingre_name'];
            // print('text:$text');

            if (containsIngredient(text, otherNames)) {
              var recipeName = recipeDocument['recipe_name'];
              var step = recipeDocument['context'];
              var liked = recipeDocument['liked'];
              var image = recipeDocument['image'];

              print(
                  'Recipe Name: $recipeName, Text: $text, Step: $step, Liked: $liked, Image: $image');

              SerecipeData.add({
                'title': recipeName,
                'text': text,
                'imagepath': image,
                'step': step,
                'liked': liked,
              });
            }
            print('進入篩選食材4');
          });
        } else{
          print('recipeQuerySnapshot.docs is empty');
        }
      }
    }
    print('準備return篩選食材5');
    print(SerecipeData);
    return SerecipeData;
  } catch (e) {
    print('Error: $e');
    return [];
  }
}

bool containsIngredient(String text, List<dynamic> otherNames) {
  for (var name in otherNames) {
    if (text.contains(name)) {
      print('有找到相關食材食譜');
      return true;
    }
  }
  print('no找到相關食材食譜');
  return false;
}

