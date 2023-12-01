import 'package:flutter/material.dart';
import 'package:flutter_app_test/home/actions/collection/recipe/recipe_page.dart';
import 'package:flutter_app_test/mainpage/recipesearch/title_with_text.dart';
import '../../../colors.dart';
import 'getCollection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class CollectionPage extends StatefulWidget {
  const CollectionPage(
      {Key? key,
        required this.press,})
      : super(key: key);
  final Function() press;
  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

List<Map<String, dynamic>> recipeData = []; // 食譜的 List

class _CollectionPageState extends State<CollectionPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('recipes')
          .where('liked', isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          final int recipeCount = snapshot.data!.docs.length;


          // 將留言資料保存到 commentsData 中
          recipeData = snapshot.data!.docs.map((document) {

            return {
              'title': document['recipe_name'] as String,
              'text': document['ingre_name'] as String,
              'imagepath': document['image'] as String,
              'step': document['context'] as String,
              'liked': document['liked'] as bool,
            };


            // }).whereType<Map<String, dynamic>>().toList();
          }).toList();
          // print(recipeData);
          print("成功抓到收藏食譜");


          if (recipeCount > 0) {
            // 這裡不再回傳 Widget，只回傳一個空的 Container
            return Scaffold(

              extendBodyBehindAppBar: true,
              //backgroundColor: kHomeBackgroundColor,
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
                  '我的收藏',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              body: SafeArea(
                child: ListView.builder(
                    itemCount: recipeData.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          '${recipeData[index]['title']}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                          ),
                        ),
                        onTap: () {
                          print('${recipeData[index]['title']}');
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => RecipePage(
                                title: '${recipeData[index]['title']}',
                                text: '${recipeData[index]['text']}',
                                imagepath: '${recipeData[index]['imagepath']}',
                                step: '${recipeData[index]['step']}',
                                liked: recipeData[index]['liked'], )));
                        },
                      );
                    }),
              ),
            );
            return Container();
          } else {
            return Scaffold(

              extendBodyBehindAppBar: true,
              //backgroundColor: kHomeBackgroundColor,
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
                  '我的收藏',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  alignment: Alignment.center,
                  child: const Text(
                    '還沒有喜歡的食譜...',
                    style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 30,),
                  ),
                )
              ),
            );
          }



        }


        }

    );


  }
}
