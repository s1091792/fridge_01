import 'dart:async';

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/colors.dart';
import 'package:flutter_app_test/mainpage/foodmanager/foodstitle_with_more_btn.dart';
import 'package:flutter_app_test/mainpage/foodmanager/main_foods_pic.dart';
import 'package:flutter_app_test/mainpage/recipesearch/SelectedListController.dart';
import 'package:get/get.dart';
import '../foodmanager/morepage.dart';
import '../foodmanager/new_food.dart';
import '../recipesearch/title_with_text.dart';
import '../foodmanager/getFood.dart';
import '../foodmanager/SearchFood.dart';
import '../recipesearch/SearchRecipe.dart';
import '../shoppinglist/ShpList_helper.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class foodmanager extends StatefulWidget {
  const foodmanager({Key? key}) : super(key: key);

  @override
  State<foodmanager> createState() => _foodmanagerState();
}

class _foodmanagerState extends State<foodmanager> {
  final myController = TextEditingController();
  String text = "尚未接收資料";
  Future<List<Map<String, dynamic>>>? searchDataFuture;



  @override
  void initState() {
    super.initState();
    print("食材管理init");
    searchDataFuture = SearchFood(myController.text);
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget buildFoodListWidget() {
    return Column(
      children: [
        myController.text.isEmpty
            ? Column(
                children: [
                  Column(
                    children: <Widget>[
                      TitleWithMorebtn(
                          title: "已過期",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MorePage(
                                  title: commentsData0
                                      .map((comment) =>
                                          comment['title'] as String)
                                      .toList(),
                                  date: commentsData0
                                      .map((comment) =>
                                          comment['date'] as String)
                                      .toList(),
                                  number: commentsData0
                                      .map(
                                          (comment) => comment['number'] as int)
                                      .toList(),
                                  image: commentsData0
                                      .map((comment) =>
                                          comment['image'] as String)
                                      .toList(),
                                  press: () {}, color: kFoodexpired,
                                ),
                              ),
                            );
                          }, color: kFoodexpired,),
                      getFood0(),
                    ],
                  ),
                  const SizedBox(
                    height: kDefaultPadding / 2,
                  ),

                  Column(
                    children: <Widget>[
                      TitleWithMorebtn(
                          title: "七日內到期",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MorePage(
                                  title: commentsData7
                                      .map((comment) =>
                                          comment['title'] as String)
                                      .toList(),
                                  date: commentsData7
                                      .map((comment) =>
                                          comment['date'] as String)
                                      .toList(),
                                  number: commentsData7
                                      .map(
                                          (comment) => comment['number'] as int)
                                      .toList(),
                                  image: commentsData7
                                      .map((comment) =>
                                          comment['image'] as String)
                                      .toList(),
                                  press: () {}, color: kPrimaryColor,
                                ),
                              ),
                            );
                          }, color: kTextColor,),
                      getFood7(),
                    ],
                  ),
                  const SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Column(
                    children: [
                      TitleWithMorebtn(
                          title: "十五日內到期",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MorePage(
                                  title: commentsData15
                                      .map((comment) =>
                                          comment['title'] as String)
                                      .toList(),
                                  date: commentsData15
                                      .map((comment) =>
                                          comment['date'] as String)
                                      .toList(),
                                  number: commentsData15
                                      .map(
                                          (comment) => comment['number'] as int)
                                      .toList(),
                                  image: commentsData15
                                      .map((comment) =>
                                          comment['image'] as String)
                                      .toList(),
                                  press: () {}, color: kPrimaryColor,
                                ),
                              ),
                            );
                          }, color: kTextColor,),
                      getFood15(),
                    ],
                  ),
                  //seven_food_pic(),
                  const SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Column(
                    children: [
                      TitleWithMorebtn(
                          title: "三十日內到期",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MorePage(
                                  title: commentsData30
                                      .map((comment) =>
                                          comment['title'] as String)
                                      .toList(),
                                  date: commentsData30
                                      .map((comment) =>
                                          comment['date'] as String)
                                      .toList(),
                                  number: commentsData30
                                      .map(
                                          (comment) => comment['number'] as int)
                                      .toList(),
                                  image: commentsData30
                                      .map((comment) =>
                                          comment['image'] as String)
                                      .toList(),
                                  press: () {}, color: kPrimaryColor,
                                ),
                              ),
                            );
                          }, color: kTextColor,),
                      getFood30(),
                    ],
                  ),
                  const SizedBox(
                    height: kDefaultPadding / 2,
                  ),

                  Column(
                    children: <Widget>[
                      TitleWithMorebtn(
                          title: "其餘食材",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MorePage(
                                  title: commentsData31
                                      .map((comment) =>
                                          comment['title'] as String)
                                      .toList(),
                                  date: commentsData31
                                      .map((comment) =>
                                          comment['date'] as String)
                                      .toList(),
                                  number: commentsData31
                                      .map(
                                          (comment) => comment['number'] as int)
                                      .toList(),
                                  image: commentsData31
                                      .map((comment) =>
                                          comment['image'] as String)
                                      .toList(),
                                  press: () {}, color: kPrimaryColor,
                                ),
                              ),
                            );
                          }, color: kTextColor,),
                      getFood31(),
                    ],
                  ),
                ],
              )
            : Column(
                children: [
                  FutureBuilder<List<Map<String, dynamic>>>(
                    // future: SearchFood(myController.text),
                    future: searchDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print('食材轉圈圈');
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // var data = snapshot.data;
                        List<Map<String, dynamic>>? data = snapshot.data;

                        if (data != null && data.isNotEmpty) {
                          print('Data Received: $data');
                          // 在这里使用 data
                          return seven_food_pic(
                            title: data
                                .map((recipe) => recipe['title'] as String)
                                .toList(),
                            date: data
                                .map((recipe) => recipe['date'] as String)
                                .toList(),
                            number: data
                                .map((recipe) => recipe['number'] as int)
                                .toList(),
                            press: () {},
                            image: data
                                .map((recipe) => recipe['image'] as String)
                                .toList(),
                            color: kPrimaryColor,
                          );
                        } else {
                          // 处理 data 为 null 的情况
                          // return const CircularProgressIndicator();
                          return const Center(
                              child: Text('沒有搜尋結果' ,

                                style: TextStyle(
                                  fontSize: 30,
                                  // 其他 TextStyle 屬性...
                                ),

                              )
                          );

                        }
                      }
                    },
                  )
                ],
              )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('food').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              //外部間距
                              margin: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              //外部間距
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              width: size.width / 1.4,
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 10),
                                    blurRadius: 50,
                                    color: kPrimaryColor.withOpacity(0.23),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: myController,
                                      //onSubmitted 按enter後搜尋資料，呼叫seven_food_pic填資料
                                      onSubmitted: (_) {
                                        print('呼叫enter搜尋');
                                        setState(() {
                                          searchDataFuture = SearchFood(myController.text);
                                          // buildFoodListWidget();
                                        });
                                        //
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Search",
                                        hintStyle: TextStyle(
                                          color: kTextColor.withOpacity(0.5),
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        // surffix isn't working properly  with SVG
                                        // thats why we use row
                                        // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    //onPressed跟onSubmitted 一樣搜尋資料
                                    onPressed: () {
                                      if (myController.text.isNotEmpty) {
                                        print('呼叫按下搜尋');
                                        setState(() {
                                          searchDataFuture = SearchFood(myController.text);
                                          // buildFoodListWidget();
                                        });
                                      }


                                    },
                                    icon: Image.asset(
                                      'assets/icons/search.png',
                                      color: kTextColor.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: CircleAvatar(
                                  backgroundColor:
                                      kPrimaryColor.withOpacity(0.5),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const NewFood(),
                                          ),
                                        );
                                      },
                                      icon: Image.asset(
                                        'assets/icons/plus.png',
                                        color: kTextColor.withOpacity(0.5),
                                      ))),
                            ),
                          ],
                        ),
                        //foodmanager(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  //
                  Column(children: <Widget>[buildFoodListWidget()]),

                  //seven_food_pic(),
                ],
              ),
            ),
          );
        });
  }
}

//食譜篩選食材用的list
List<String> defaultList = [];
List<Map<String, dynamic>> recipeData = []; // 食譜的 List
List<Map<String, dynamic>> DefaultListdata = [];

void getDefaultList() async {
  print("進入搜尋食譜2");
  final collection = FirebaseFirestore.instance.collection('food');
  final querySnapshot = await collection.where('food_name').get();

  defaultList.clear();

  if (querySnapshot.docs.isNotEmpty) {
    print("進入篩選-食材3");

    for (var doc in querySnapshot.docs) {
      final document = doc.data();
      print(document);

      print("有抓到篩選-食材");
      defaultList.add(document['food_name'] as String);
      print('defaultList：$defaultList');
    }
  } else {
    print("進入篩選-食材no");
  }
}

class recipesearch extends StatefulWidget {
  const recipesearch({Key? key}) : super(key: key);

  @override
  State<recipesearch> createState() => _recipesearchState();
}

class _recipesearchState extends State<recipesearch> {
  var controller = Get.put(SelectedListController());
  final myController = TextEditingController();
  StreamController<String> searchController = StreamController<String>();
  Stream<List<Map<String, dynamic>>>? searchDataFuture;

  @override
  void initState() {
    super.initState();
    getDefaultList();
    searchDataFuture = SearchRecipe(myController.text);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    //controller.dispose();
    print("離開食譜查詢");
    searchController.close();
    super.dispose();
  }

  //此openFilterDialog用來篩選食材
  void openFilterDialog(context) async {
    await FilterListDialog.display<String>(context,
        listData: defaultList,
        selectedListData: controller.getSelectedList(),
        headlineText: '篩選食材',
        //applyButtonText: TextStyle(fontSize: 20),
        choiceChipLabel: (String? item) => item,
        validateSelectedItem: (list, val) => list!.contains(val),
        onItemSearch: (list, text) {
          return list.toLowerCase().contains(text.toLowerCase());
        },
        onApplyButtonClick: (list) async {
          setState(() {
            controller.setSelectedList(List<String>.from(list!));
          });
          //Get.back();
          //await Future.delayed(const Duration(milliseconds: 300));
          Navigator.pop(context);
        });
  }

  Widget buildRecipeListWidget(Size size) {
    print('開始搜尋');
    return Column(
      children: [
        //controller.getSelectedList()=dialog裡有沒有選東西null就顯示"沒結果"(Center(child: Text('沒有搜尋結果')))or預設食譜
        //有就用 controller.getSelectedList()![index] 取裡面的東西
        (controller.getSelectedList() == null ||
                    controller.getSelectedList()!.length == 0) &&
                myController.text.isEmpty
            ? Column(
                children: [
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.only(left: kDefaultPadding),
                    child: const Text(
                      "推薦食譜",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //getRecipe(),
                  recipe_title_text(
                    size: size,
                    title: recipeData
                        .map((recipe) => recipe['title'] as String)
                        .toList(),
                    text: recipeData
                        .map((recipe) => recipe['text'] as String)
                        .toList(),
                    imagepath: recipeData
                        .map((recipe) => recipe['imagepath'] as String)
                        .toList(),
                    step: recipeData
                        .map((recipe) => recipe['step'] as String)
                        .toList(),
                    press: () {},
                    liked: recipeData
                        .map((recipe) => recipe['liked'] as bool)
                        .toList(),
                    // liked: [false,false,false,false],
                  ),
                ],
              )
            : myController.text.isEmpty
                ? StreamBuilder<List<Map<String, dynamic>>>(
                    stream: findRecipesStream(controller.getSelectedList()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // var data = snapshot.data;
                        List<Map<String, dynamic>>? data = snapshot.data;

                        if (data != null && data.isNotEmpty) {
                          // 在这里使用 data
                          return recipe_title_text(
                            size: size,
                            title: data
                                .map((recipe) => recipe['title'] as String)
                                .toList(),
                            text: data
                                .map((recipe) => recipe['text'] as String)
                                .toList(),
                            imagepath: data
                                .map((recipe) => recipe['imagepath'] as String)
                                .toList(),
                            step: data
                                .map((recipe) => recipe['step'] as String)
                                .toList(),
                            press: () {},
                            liked: data
                                .map((recipe) => recipe['liked'] as bool)
                                .toList(),
                          );
                        } else {
                          // 处理 data 为 null 的情况
                          // return const CircularProgressIndicator();
                          return const Center(
                              child: Text('沒有搜尋結果' ,

                                style: TextStyle(
                                  fontSize: 30,
                                  // 其他 TextStyle 屬性...
                                ),

                              )
                          );
                        }
                      }
                    },
                  )
                : Column(
                    children: [
                      StreamBuilder<List<Map<String, dynamic>>>(
                        // stream: SearchRecipe(myController.text),
                        stream: searchDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // var data = snapshot.data;
                            List<Map<String, dynamic>>? data = snapshot.data;

                            if (data != null && data.isNotEmpty) {
                              print('Data Received: $data');
                              // 在这里使用 data
                              return recipe_title_text(
                                size: size,
                                title: data
                                    .map((recipe) => recipe['title'] as String)
                                    .toList(),
                                text: data
                                    .map((recipe) => recipe['text'] as String)
                                    .toList(),
                                imagepath: data
                                    .map((recipe) =>
                                recipe['imagepath'] as String)
                                    .toList(),
                                step: data
                                    .map((recipe) => recipe['step'] as String)
                                    .toList(),
                                press: () {},
                                liked: data
                                    .map((recipe) => recipe['liked'] as bool)
                                    .toList(),
                              );
                            } else {
                              // 处理 data 为 null 的情况
                              // return const CircularProgressIndicator();
                              return const Center(
                                  child: Text('沒有搜尋結果' ,

                                    style: TextStyle(
                                      fontSize: 30,
                                      // 其他 TextStyle 屬性...
                                    ),

                                  )
                              );
                            }

                          }


                        },
                      )
                    ],
                  )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final int recipeCount = snapshot.data!.docs.length;

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
            print("成功抓到食譜");

            if (recipeCount > 0) {
              // 這裡不再回傳 Widget，只回傳一個空的 Container
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                //外部間距
                                margin: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                //外部間距
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                width: size.width / 1.4,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 10),
                                      blurRadius: 50,
                                      color: kPrimaryColor.withOpacity(0.23),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextField(
                                        controller: myController,
                                        //onSubmitted 按enter後搜尋資料，呼叫recipe_title_text填資料
                                        onSubmitted: (_) {

                                          searchDataFuture = SearchRecipe(myController.text);

                                        },
                                        decoration: InputDecoration(
                                          hintText: "Search",
                                          hintStyle: TextStyle(
                                            color: kTextColor.withOpacity(0.5),
                                          ),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          // surffix isn't working properly  with SVG
                                          // thats why we use row
                                          // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      //onPressed記得用跟上面textfile onSubmitted一樣的
                                      onPressed: () {

                                        setState(() {
                                          searchDataFuture = SearchRecipe(myController.text);
                                          buildRecipeListWidget(size);
                                        });

                                      },
                                      icon: Image.asset(
                                          'assets/icons/search.png'),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: CircleAvatar(
                                    backgroundColor:
                                        kPrimaryColor.withOpacity(0.5),
                                    child: IconButton(
                                        onPressed: () =>
                                            openFilterDialog(context),
                                        icon: Image.asset(
                                          'assets/icons/filter.png',
                                          color: kTextColor.withOpacity(0.5),
                                        ))),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[buildRecipeListWidget(size)],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                alignment: Alignment.center,
                child: const Text(
                  'no recipe...',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
          }
        });
  }
}

///////////////////

/*class SearchintoWidget extends StatefulWidget {
  const SearchintoWidget({super.key});

  @override
  _SearchintoWidgetState createState() => _SearchintoWidgetState();
}

class _SearchintoWidgetState extends State<SearchintoWidget> {
  List<Map<String, dynamic>> data = [];

  final myController = TextEditingController();
  late Size size;

  @override
  void initState() {
    super.initState();
    // 初始化 size
    size = MediaQuery.of(context).size;
    SearchRecipe(myController.text);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: SearchRecipe(myController.text),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Update the data when the stream emits new values
          data = snapshot.data?.map((item) => {'title': item}).toList() ?? [];
          print('進入SearchRecipe');

          if (data.isNotEmpty) {
            // Render your UI using the updated data
            return recipe_title_text(
              size: size,
              title: data.map((recipe) => recipe['title'] as String).toList(),
              text: data.map((recipe) => recipe['text'] as String).toList(),
              imagepath:
                  data.map((recipe) => recipe['imagepath'] as String).toList(),
              step: data.map((recipe) => recipe['step'] as String).toList(),
              press: () {},
              liked: data.map((recipe) => recipe['liked'] as bool).toList(),
            );
          } else {
            // Handle the case where data is empty
            return const CircularProgressIndicator();
          }
        }
      },
    );
  }
}*/

////////////////////

List<Map<String, dynamic>> ShpList = [];

class shoppinglist extends StatelessWidget {
  const shoppinglist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const list_checkbox();
  }
}

class list_checkbox extends StatefulWidget {
  const list_checkbox({
    super.key,
  });

  @override
  State<list_checkbox> createState() => _list_checkboxState();
}

class _list_checkboxState extends State<list_checkbox> {
  TextEditingController controller = TextEditingController();
  String name = '';
  List<Map> categories = [
    //將資料庫裡的資料先放進來
    /*{"title": "蘋果", "isChecked": false},*/
  ];
  @override
  void inidState() {
    super.initState();
    print("進入購物清單");
  }

  @override
  void dispose() {
    print('購物清單的dispose方法(離開)');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('shplist').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final int ShpListCount = snapshot.data!.docs.length;

            // print("開抓購物清單2");

            // 將留言資料保存到 commentsData 中
            ShpList = snapshot.data!.docs
                .map((document) {
                  try {
                    print("有抓到購物清單");
                    return {
                      'title': document['shp_name'] as String,
                      'isChecked': document['isChecked'] as bool,
                    };
                  } catch (e) {
                    print("沒抓到購物清單：$e");
                  }
                })
                .whereType<Map<String, dynamic>>()
                .toList();
            print("get抓購物：$ShpList");

            if (ShpListCount > 0) {
              // 這裡不再回傳 Widget，只回傳一個空的 Container
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //gett(),
                    //新增名稱按鈕
                    CircleAvatar(
                        backgroundColor: kPrimaryColor.withOpacity(0.5),
                        child: IconButton(
                            //此按鈕接收dialog中的數值
                            onPressed: () async {
                              final name = await openDialog(context);
                              if (name == null || name.isEmpty) return;
                              setState(() => this.name = name);
                              //將東西新增進去list<map>categories裡面或資料庫
                              //已經在dialog新增進去的話這幾行都可以刪了

                              setState(() {
                                print('新增購物');
                                createNewShpDocument();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("新增成功"),
                                  duration: Duration(seconds: 1),
                                ));
                                /*ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Container(
                                      height: 90,
                                      decoration:
                                      const BoxDecoration(color: Colors.red),
                                      child: Text("新增成功")),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                ));*/
                              });
                            },
                            icon: Image.asset(
                              "assets/icons/plus.png",
                              color: kTextColor.withOpacity(0.5),
                            ))),

                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: getSh(
                        title: ShpList.map((shp) => shp['title'] as String)
                            .toList(),
                        isChecked:
                            ShpList.map((shp) => shp['isChecked'] as bool)
                                .toList(),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: kPrimaryColor.withOpacity(0.5),
                        child: IconButton(
                            //此按鈕接收dialog中的數值
                            onPressed: () async {
                              final name = await openDialog(context);
                              if (name == null || name.isEmpty) return;
                              setState(() => this.name = name);
                              //將東西新增進去list<map>categories裡面或資料庫
                              //已經在dialog新增進去的話這幾行都可以刪了

                              setState(() {
                                print('新增購物');
                                createNewShpDocument();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("新增成功"),
                                  duration: Duration(seconds: 1),
                                ));
                                /*ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Container(
                                      height: 90,
                                      decoration:
                                      const BoxDecoration(color: Colors.red),
                                      child: Text("新增成功")),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                ));*/
                              });
                            },
                            icon: Image.asset(
                              "assets/icons/plus.png",
                              color: kTextColor.withOpacity(0.5),
                            ))),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      alignment: Alignment.center,
                      child: const Text(
                        '還沒有清單...',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        });
  }

  Future<String?> openDialog(BuildContext context) => showDialog<String>(
        context: context,
        builder: (context) => GestureDetector(
          onTap: () => Navigator.pop(context),
          behavior: HitTestBehavior.opaque,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox(
              width: double.maxFinite,
              height: 350,
              child: AlertDialog(
                title: const Text("新增物品"),
                content: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: '名稱：',
                        labelText: 'name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      controller: controller,
                      onSubmitted: (_) {
                        //此處新增進資料庫：食材名稱的變數為controller.text
                        Navigator.of(context).pop(controller.text);
                        controller.clear();
                        //submit();
                      },
                      onChanged: (text) {
                        print('食材名稱: $text');
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                actions: [
                  TextButton(onPressed: () => submit(), child: const Text("取消")),
                  TextButton(
                      onPressed: () {
                        //此處新增進去資料庫
                        Navigator.of(context).pop(controller.text);
                        controller.clear();
                      },
                      child: const Text("新增")),
                ],
              ),
            ),
          ),
        ),
      );
  void submit() {
    Navigator.pop(context);
    controller.clear();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void createNewShpDocument() async {
    String shpId = firestore.collection('shplist').doc().id;

    try {
      Map<String, dynamic> shpData = {
        'isChecked': false,
        'shp_name': name,
      };
      await firestore.collection('shplist').doc(shpId).set(shpData);
      print('創建購物清單文件成功');
    } catch (e) {
      print('創建購物清單文件時發生錯誤：$e');
    }
  }
}
