import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/colors.dart';

class seven_food_pic extends StatefulWidget {
  const seven_food_pic({
    super.key,
    required this.title,
    required this.date,
    required this.number,
    required this.press,
    required this.image,
  });
  final List<String> title, date;
  final List<int> number;
  final Function() press;
  final List<String> image;
  @override
  State<seven_food_pic> createState() => _seven_food_picState();
}

class _seven_food_picState extends State<seven_food_pic> {
  // var name;

  @override
  Widget build(BuildContext context) {
    Future<String?> openSLDialog(
        BuildContext context,
        String name,
        ) =>
        showDialog<String>(
          context: context,
          builder: (context) => Padding(
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
                      Navigator.pop(context);
                    },
                    child: Text("取消")),
                TextButton(
                    onPressed: () {
                      //此地加入購物清單
                      createNewShpDocument(name);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("新增成功"),
                      ));
                      Navigator.pop(context);
                    },
                    child: const Text("確認",style: TextStyle(color: Colors.red),)),
              ],
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
              title: Text(
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("刪除成功"),
                      ));
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
    return widget.title.isEmpty?Container():SizedBox(
      width: double.maxFinite,
      height: 182,
      child: ListView.builder(
          itemCount: widget.title.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onLongPress: () {
                openDialog(context, widget.title[index]);
              },
              child: Container(
                margin:
                    const EdgeInsets.only(left: kDefaultPadding - 5, top: 10),
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      height: 130,
                      image: widget.image[index],
                      placeholder: 'assets/images/icecofe.png',
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimaryColor.withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      " ${widget.title[index]}\n".toUpperCase(),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                TextSpan(
                                  text: " ${widget.date[index]}".toUpperCase(),
                                  style: TextStyle(
                                    color: kPrimaryColor.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${widget.number[index]} ',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: kPrimaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
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
