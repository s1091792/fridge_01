/*

home_page.dart：選冰箱的頁面
main_page.dart：十材管理食譜購物清單那個頁面
../main_category.dart：全部的畫面

main_page/component/getFood.dart：抓食材
foodmanager/main_foods_pic.dart：做出食材圖案的東西

recipesearch/getRecipe.dart：抓食譜
../title_with_text.dart：做出食鋪的東西


 */


// //im.ge的api
// void uploadImageToImge() async {
//   // 設置 API 金鑰（在您申請 API 金鑰後，將其放在這裡）
//   final apiKey = '26qrIzVXzPe1m1NrnbvgRvMslW0NAvzPmrCgWLDd';
//
//   // 圖像文件的本地路徑
//   final imagePath1 = imageFile!.path;
//   final imagePath2 = Uri.file(imageFile!.path);
//
//   // final localFilePath = '/path/to/your/local/file.jpg'; // 本地文件的路徑
//   // final uri = Uri.file(imageFile!.path);
//
//   print(imagePath2.toString()); // 這將打印有效的http URI
//
//   // 讀取圖像文件的內容
//   final imageBytes = File(imagePath1).readAsBytesSync();
//
//   if (imageBytes.isNotEmpty) {
//     print('圖像內容有');
//
//     // 構建 API 請求
//     final uri = Uri.parse('https://im.ge/api/1/upload?key=$apiKey&format=json');
//     // final uri = Uri.parse('https://im.ge/api/1/upload?key=$apiKey');
//     final request = http.MultipartRequest('POST', uri)
//       ..files.add(http.MultipartFile.fromBytes('source', imageBytes, filename: generateRandomFileName()));
//
//     try {
//       final response = await http.Response.fromStream(await request.send());
//
//       // 解析 API 回應
//       final data = json.decode(response.body);
//       final statusCode = data['status_code'];
//
//       if (statusCode == 200) {
//         final imageUrl = data['image']['url'];
//         print('圖片連結：$imageUrl');
//       } else {
//         final statusTxt = data['status_txt'];
//         print('上傳失敗，狀態代碼：$statusCode，狀態訊息：$statusTxt');
//       }
//     } catch (e) {
//       print('error：$e');
//     }
//
//   } else {
//     // `imageBytes` 為空，沒有有效內容
//     print('圖像內容為空');
//   }
//
//
// }
//
// // 隨機英文數字的文件名
// String generateRandomFileName() {
//   final random = Random();
//   const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
//   final fileName = List.generate(10, (index) => chars[random.nextInt(chars.length)]).join();
//   // print('$fileName');
//   return '$fileName';
// }




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


