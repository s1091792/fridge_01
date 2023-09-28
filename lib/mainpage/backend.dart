/*

home_page.dart：選冰箱的頁面
main_page.dart：十材管理食譜購物清單那個頁面
../main_category.dart：全部的畫面

main_page/component/getFood.dart：抓食材
foodmanager/main_foods_pic.dart：做出食材圖案的東西

recipesearch/getRecipe.dart：抓食譜
../title_with_text.dart：做出食鋪的東西


 */



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


