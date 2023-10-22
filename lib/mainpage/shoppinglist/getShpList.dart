// // // getShpList.dart
// import 'ShpList_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import '../components/main_category.dart';
import 'ShpList_helper.dart';

// void gett(List<Map<String, dynamic>> shpListData) {
//   print("有gett");
//   categories = [
//
//     //將資料庫裡的資料先放進來
//     {
//       'title': ShpList.map((shp) => shp['title'] as String).toList(),
//       'isChecked': ShpList.map((shp) => shp['isChecked'] as bool).toList(),
//       // "title": "蘋果", "isChecked": false
//     }
//   ];
// }
List<Map<String, dynamic>> ShpList = [];

StreamBuilder<QuerySnapshot> gett() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('shplist')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );
      final int ShpListCount = snapshot.data!.docs.length;

      // print("開抓購物清單2");

      // 將留言資料保存到 commentsData 中
      ShpList = snapshot.data!.docs.map((document) {

        try {
          print("有抓到購物清單");
          return {
            'title': document['shp_name'] as String,
            'isChecked': document['isChecked'] as bool,
          };
        } catch (e) {
          print("沒抓到購物清單：$e");
        }


      }).whereType<Map<String, dynamic>>().toList();
      // }).toList();
      print("get抓購物：$ShpList");
      // gett(ShpList);


      if (ShpListCount > 0) {
        // 這裡不再回傳 Widget，只回傳一個空的 Container
        return Container();
      } else {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          child: Text(
            'no food...',
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    },
  );
}

