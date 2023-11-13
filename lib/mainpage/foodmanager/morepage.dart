//參考：https://www.youtube.com/watch?v=M0Gs1aJniv0
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/mainpage/main_page.dart';
import '../../colors.dart';

class MorePage extends StatefulWidget {
  MorePage({Key? key, required this.title, required this.date, required this.number, required this.image, required this.press}) : super(key: key);

  final List<String> title, date;
  final List<int> number;
  final List<String> image;
  final Function() press;

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  Future<String?> openSLDialog(
      BuildContext context,
      String name,
      ) =>
      showDialog<String>(
        context: context,
        builder: (context) => Container(
          height: 200,
          width: double.infinity,
          child: Padding(
            padding:
            const EdgeInsets.all(kDefaultPadding),
            child: AlertDialog(
              title: Text(
                "加入購物清單",
                style: TextStyle(
                    fontSize: 30, color: Colors.red),
              ),
              content: Column(
                children: [
                  Text(
                    "要將$name加入購物清單嗎?",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                      );
                    },
                    child: Text("取消")),
                TextButton(
                    onPressed: () {
                      //此地加入購物清單
                      createNewShpDocument(name);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                      );
                    },
                    child: const Text("確認",style: TextStyle(color: Colors.red),)),
              ],
            ),
          ),
        ),
      );
  Future<String?> openDialog(
      BuildContext context,
      String name,
      ) =>
      showDialog<String>(
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 190),
          child: AlertDialog(
            title: const Text(
              "刪除食材",
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
            content: Column(
              children: [
                Text(
                  "確定要刪除$name嗎?",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("取消")),
              TextButton(
                  onPressed: () {
                    //此地方刪除食材
                    deleteFoodDocument(name);
                    //按確認後先返回食材再
                    Navigator.pop(context);
                    //跳出是否加入購物清單
                    openSLDialog(context,name);
                  },
                  child: Text("確認",style: TextStyle(color: Colors.red))),
            ],
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Image.asset("assets/icons/back.png"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              '全部食材',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('food')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: widget.title.length==0?SafeArea(
                  child: Text(
                    '目前沒有食材喔~~~',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 30,
                    ),),
                ):SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, //兩條直的
                          crossAxisSpacing: 12.0,//直的空白
                          mainAxisSpacing: 12.0,//橫的
                          mainAxisExtent: 286,
                        ),
                        itemCount: widget.title.length,
                        itemBuilder: (_, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                16.0,
                              ),
                              color: kPrimaryColor.withOpacity(0.3),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0),
                                  ),
                                  child: Image.network(
                                    widget.image[index],
                                    height: 170,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.title[index]}",
                                        style: Theme.of(context).textTheme.titleMedium!.merge(
                                              const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${widget.date[index]}",
                                            style: Theme.of(context).textTheme.titleSmall!.merge(
                                                  TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                          ),
                                          Spacer(),//放最右邊
                                          Text(
                                            "${widget.number[index]}",
                                            style: Theme.of(context).textTheme.titleSmall!.merge(
                                              TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          /*IconButton(
                                            onPressed: () {
                                              //編輯食材
                                            },
                                            icon: Icon(
                                              Icons.mode,
                                            ),
                                          ),*/
                                          Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              //刪除食材
                                              openDialog(context, widget.title[index]);
                                              //deleteFoodDocument(widget.title[index]);
                                              //Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              CupertinoIcons.trash,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        );
  }
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void deleteFoodDocument(String foodName) async {

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('food')
          .where('food_name', isEqualTo: foodName)
          .get();

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.delete();
      }
      print('刪除食物文件成功： $foodName');
    } catch (e) {
      print('刪除食物文件時發生錯誤：$e');
    }
  }

  void createNewShpDocument(String shpname) async {
    String shpId = firestore.collection('shplist').doc().id;

    try {
      Map<String, dynamic> shpData = {
        'isChecked': false,
        'shp_name': shpname,
      };
      await firestore.collection('shplist').doc(shpId).set(shpData);
      print('創建購物清單文件成功');
    } catch (e) {
      print('創建購物清單文件時發生錯誤：$e');
    }
  }
}
