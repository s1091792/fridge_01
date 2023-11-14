/*

home_page.dart：選冰箱的頁面
main_page.dart：十材管理食譜購物清單那個頁面
../main_category.dart：全部的畫面

main_page/component/getFood.dart：抓食材
foodmanager/main_foods_pic.dart：做出食材圖案的東西

recipesearch/getRecipe.dart：抓食譜
../title_with_text.dart：食譜畫面

drawer_page：旁邊側邊
collection_page：點我的收藏進來 總攬
recipe_page：收藏頁面點進去的食譜

findRecipesByIngredient(controller.getSelectedList());

 */


// void selecFunction(){
//   findRecipesByIngredient(controller.getSelectedList());
//   recipe_title_text(
//       // size: size,
//       // title: controller.getSelectedList(),
//       size: size,
//       title: SrecipeData.map((recipe) =>
//   recipe['title'] as String)
//       .toList(),
//   text: SrecipeData.map((recipe) =>
//   recipe['text'] as String)
//       .toList(),
//   imagepath: SrecipeData.map(
//   (recipe) => recipe['imagepath']
//   as String).toList(),
//   step: SrecipeData.map((recipe) =>
//   recipe['step'] as String)
//       .toList(),
//   press: () {},
//   liked: recipeData
//       .map((recipe) =>
//   recipe['liked'] as bool)
//   .toList(),
// };





// import 'package:cloud_firestore/cloud_firestore.dart';
//
// FirebaseFirestore firestore = FirebaseFirestore.instance;
//
// void createFridgeDocument() async {
//   String fridgeId = firestore
//       .collection('fridge')
//       .doc()
//       .id;
// }
//
// //新增冰箱在firestore fridge/隨機id/......
// void createNewfoodDocument() async {
//   String foodId = firestore
//       .collection('food')
//       .doc()
//       .id;
//
//   try {
//       Map<String, dynamic> foodData = {
//         // 'googleAccount': user.email,
//         // 'fridge_name': '冰箱名稱', //這裡到時候要記得改ㄛ
//         // 'fridge_color': '冰箱顏色',
//         // 'food_id': '食品id',
//         'food_name': text,
//
//       };
//       await firestore.collection('food').doc(foodId).set(foodData);
//       print('創建食材文件成功');
//     } catch (e) {
//       print('創建食材文件時發生錯誤：$e');
//     }


// void addLikedFieldToRecipes() async {
//   final firestoreInstance = FirebaseFirestore.instance;
//
//   // 获取 recipes 集合的引用
//   CollectionReference recipesCollection = firestoreInstance.collection('recipes');
//
//   // 获取 recipes 集合中的所有文档
//   QuerySnapshot recipes = await recipesCollection.get();
//
//   // 针对每个文档，添加 liked 字段并设置为 false
//   recipes.docs.forEach((recipes) async {
//     // 使用 set 方法添加 liked 字段
//     await recipes.reference.set({'liked': false}, SetOptions(merge: true));
//   });
//
//   print('liked 字段已成功添加到所有文档');
// }