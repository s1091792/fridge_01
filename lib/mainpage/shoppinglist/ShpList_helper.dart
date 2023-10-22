import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import '../components/main_category.dart';
import 'getShpList.dart';
//
//
//
// List<Map<String, dynamic>> ShpList = []; // 購物清單的 List
//
// StreamBuilder<QuerySnapshot> getShpList() {
//   return StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance
//         .collection('shplist')
//         .snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (!snapshot.hasData)
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       final int ShpListCount = snapshot.data!.docs.length;
//
//       // print("開抓購物清單2");
//
//       // 將留言資料保存到 commentsData 中
//       ShpList = snapshot.data!.docs.map((document) {
//
//         try {
//           print("有抓到購物清單");
//           return {
//             'title': document['shp_name'] as String,
//             'isChecked': document['isChecked'] as bool,
//           };
//         } catch (e) {
//           print("沒抓到購物清單：$e");
//         }
//
//
//       }).whereType<Map<String, dynamic>>().toList();
//       // }).toList();
//       print("get抓購物：$ShpList");
//       gett(ShpList);
//
//
//       if (ShpListCount > 0) {
//         // 這裡不再回傳 Widget，只回傳一個空的 Container
//         return Container();
//       } else {
//         return Container(
//           padding: EdgeInsets.symmetric(vertical: 10.0),
//           alignment: Alignment.center,
//           child: Text(
//             'no food...',
//             style: TextStyle(fontSize: 20),
//           ),
//         );
//       }
//     },
//   );
// }
//
// void gett(List<Map<String, dynamic>> shpListData) {
//   print("有gett");
//   categories = [
//     //將資料庫裡的資料先放進來
//     {
//       'title': ShpList.map((shp) => shp['title'] as String).toList(),
//       'isChecked': ShpList.map((shp) => shp['isChecked'] as bool).toList(),
//       // "title": "蘋果", "isChecked": false
//     }
//   ];
// }

// List<Map> categories = [
//   //將資料庫裡的資料先放進來
//   // {"title": "蘋果", "isChecked": false},
//   {
//     // 'shp_name': ShpList.map((shp) => shp['shp_name'] as String).toList(),
//     // 'isChecked': ShpList.map((shp) => shp['isChecked'] as bool).toList(),
//     "title": "蘋果", "isChecked": false
//   }
//
// ];

//


class getSh extends StatefulWidget {
  getSh({
    super.key,
    required this.title,
    required this.isChecked,
  });
  final List<String> title;
  late List<bool> isChecked;

  @override
  State<getSh> createState() => _getShState();
}

class _getShState extends State<getSh> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.title.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.title[index]),
          leading: Checkbox(
            value: widget.isChecked[index],
            onChanged: (value) {
              // 处理选中状态变更
              setState(() {
                widget.isChecked[index] = value!;
              });
            },
          ),
        );
      },
    );
  }
}
