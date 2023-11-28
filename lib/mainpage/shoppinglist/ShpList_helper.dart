import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import '../../colors.dart';

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
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.maxFinite,
      height: size.height,
      child: ListView.builder(
        itemCount: widget.title.length,
        itemBuilder: (context, index) {
          return Dismissible(  //刪除的，取代掉原本的liattile
            background: Container(
              color: Colors.red,
            ),
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                //刪除資料庫裡的
                String shpName = widget.title[index];
                deleteNewShpDocument(shpName);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("刪除成功"),
                  duration: Duration(seconds: 1),
                ));
              });
            },
            child: CheckboxListTile(
                title: Text(
                  widget.title[index],
                  style: const TextStyle(fontSize: 25),
                ),
                activeColor: kPrimaryColor,
                checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                value: widget.isChecked[index],
                onChanged: (val) {
                  setState(() {
                    widget.isChecked[index] = val!;
                    print('資料名稱為：${widget.title[index]}');
                    //延時一秒後刪除打勾資料
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      print("延时1秒执行");
                      setState(() {
                        //刪除資料庫裡的
                        String shpName = widget.title[index];
                        deleteNewShpDocument(shpName);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("刪除成功"),
                          duration: Duration(seconds: 1),
                        ));
                      });
                    });
                  });
                }),
          );
        },
      ),
    );
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void deleteNewShpDocument(String shpName) async {

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('shplist')
          .where('shp_name', isEqualTo: shpName)
          .get();

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        // 获取每个文档的引用并删除
        await docSnapshot.reference.delete();
      }
      print('刪除購物清單文件成功： $shpName');
    } catch (e) {
      print('刪除購物清單文件時發生錯誤：$e');
    }
  }


}

