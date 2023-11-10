import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/colors.dart';
import 'package:flutter_app_test/mainpage/foodmanager/foodstitle_with_more_btn.dart';
import 'package:flutter_app_test/mainpage/foodmanager/main_foods_pic.dart';
import 'package:flutter_app_test/mainpage/recipesearch/SelectedListController.dart';
import 'package:get/get.dart';
import '../foodmanager/new_food.dart';
import '../recipesearch/title_with_text.dart';
import '../foodmanager/getFood.dart';
import '../foodmanager/SearchFood.dart';
import '../recipesearch/getRecipe.dart';
import '../recipesearch/SearchRecipe.dart';
import '../shoppinglist/getShpList.dart';
import '../shoppinglist/ShpList_helper.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class foodmanager extends StatefulWidget {
  const foodmanager({Key? key}) : super(key: key);

  @override
  State<foodmanager> createState() => _foodmanagerState();
}

class _foodmanagerState extends State<foodmanager> {
  final myController = TextEditingController();
  String text = "尚未接收資料";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("食材管理init");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('food')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            //外部間距
                            margin:
                                EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            //外部間距
                            padding:
                                EdgeInsets.symmetric(horizontal: kDefaultPadding),
                            width: size.width / 1.4,
                            decoration: BoxDecoration(
                              color: Color(0xFFE9EEF1),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 10),
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
                                    onSubmitted: (_){

                                      print("開始搜尋食材1：$myController.text");

                                      SearchFood(myController.text);
                                      seven_food_pic(
                                        title: SfoodData.map((comment) => comment['title'] as String).toList(),
                                        date: SfoodData.map((comment) => comment['date'] as String).toList(),
                                        number: SfoodData.map((comment) => comment['number'] as int).toList(),
                                        press: () {},
                                        image: SfoodData.map((comment) => comment['image'] as String).toList(),
                                      );

                                    },
                                    decoration: InputDecoration(
                                      hintText: "Search",
                                      hintStyle: TextStyle(
                                        color: kPrimaryColor.withOpacity(0.5),
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

                                    print("開始搜尋食材1：$myController.text");

                                    SearchFood(myController.text);
                                    seven_food_pic(
                                      title: SfoodData.map((comment) => comment['title'] as String).toList(),
                                      date: SfoodData.map((comment) => comment['date'] as String).toList(),
                                      number: SfoodData.map((comment) => comment['number'] as int).toList(),
                                      press: () {},
                                      image: SfoodData.map((comment) => comment['image'] as String).toList(),
                                    );

                                  },
                                  icon:Image.asset('assets/icons/search.png'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: CircleAvatar(
                                backgroundColor: Color(0xFFE9EEF1),
                                child: IconButton(
                                    onPressed: ()  {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewFood(),
                                        ),
                                      );
                                    },
                                    icon: Image.asset('assets/icons/plus.png'))),
                          ),
                        ],
                      ),
                      //foodmanager(),
                    ],
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Column(
                  children: <Widget>[
                    TitleWithMorebtn(title: "七日內到期", press: () {}),
                    getFood7(),
                    seven_food_pic(
                      title: commentsData7.map((comment) => comment['title'] as String).toList(),
                      date: commentsData7.map((comment) => comment['date'] as String).toList(),
                      number: commentsData7.map((comment) => comment['number'] as int).toList(),
                      press: () {},
                      image: commentsData7.map((comment) => comment['image'] as String).toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Column(
                  children: [
                    TitleWithMorebtn(title: "十五日內到期", press: () {}),
                    getFood15(),
                    seven_food_pic(
                      title: commentsData15.map((comment) => comment['title'] as String).toList(),
                      date: commentsData15.map((comment) => comment['date'] as String).toList(),
                      number: commentsData15.map((comment) => comment['number'] as int).toList(),
                      press: () {},
                      image: commentsData15.map((comment) => comment['image'] as String).toList(),
                    ),
                  ],
                ),

                //seven_food_pic(),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Column(
                  children: [
                    TitleWithMorebtn(title: "三十日內到期", press: () {}),
                    getFood30(),
                    seven_food_pic(
                      title: commentsData30.map((comment) => comment['title'] as String).toList(),
                      date: commentsData30.map((comment) => comment['date'] as String).toList(),
                      number: commentsData30.map((comment) => comment['number'] as int).toList(),
                      press: () {},
                      image: commentsData30.map((comment) => comment['image'] as String).toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding / 2,
                ),

                Column(
                  children: <Widget>[
                    TitleWithMorebtn(title: "其餘食材", press: () {}),
                    getFood31(),
                    seven_food_pic(
                      title: commentsData31.map((comment) => comment['title'] as String).toList(),
                      date: commentsData31.map((comment) => comment['date'] as String).toList(),
                      number: commentsData31.map((comment) => comment['number'] as int).toList(),
                      press: () {},
                      image: commentsData31.map((comment) => comment['image'] as String).toList(),
                    )

                  ],
                ),
                //seven_food_pic(),
              ],
            ),
          ),
        );
      }
    );
  }
}

//食譜篩選食材用的list
List<String> defaultList = [
  '牛奶',
  '番茄',
  '柳丁',
  '水餃',
  '奇異果',
  '花椰菜',
  '芥菜',
  '小白菜',
  '高麗菜',
  '葡萄柚',
  '牡蠣',
  '鹹鴨蛋',
  '青江菜',
  '香腸',
  '菜豆',
  '香菇',
  '絲瓜',
  '義大利麵',
  '小黃瓜',
  '佛手瓜',
  '西米',
  '芒果',
  '椰奶',
  '鮮奶油',
  '砂糖',
  '水',
  '金桔',
  '蒟蒻',
  '蜂蜜',
  '鮪魚',
  '葡萄',
  '生菜',
  '油',
  '醬油',
  '奶油',
  '麵',
  '油條',
  '麵腸',
  '麵粉',
  '麵糊',
  '醬',
  '蘋果醋',
  '檸檬',
  '胡椒',
  '美乃滋',
  '麥芽糖',
  '橘子',
  '雞蛋',
  '皮蛋',
  '豆腐',
  '蛋餅皮',
  '蛋黃粉',
  '蘿蔔',
  '鹽',
  '牛肋條',
  '蕃茄',
  '洋蔥',
  '雞胸肉',
  '丁香',
  '七味',
  '九層塔',
  '八角',
  '十全大補藥材',
  '三層肉',
  '土雞',
  '太白粉',
  '大白菜',
  '大骨高湯',
  '大黃瓜',
  '大腸',
  '蒜',
  '小魚干',
  '小腸',
  '小蘇打',
  '山東白菜',
  '山苦瓜',
  '山藥泥',
  '川七',
  '干貝',
  '鱸魚',
  '花生',
  '鹽水雞',
  '花瓜',
  '玉米',
  '水蜜桃',
  '羅勒葉',
  '鱈魚',
  '鰹魚',
  '蝦',
  '鹹菜乾',
  '蘑菇',
  '蘋果',
  '蘆筍',
  '糯米醋',
  '糯米粉',
  '鯛魚',
  '蟹肉棒',
  '臘腸',
  '臘肉',
  '羅漢果',
  '雞粉',
  '雞肉',
  '鎮江醋',
  '醬瓜',
  '鴻喜菇',
  '鮮雞粉',
  '黑木耳',
  '鮮魚尾',
  '鮭魚',
  '泡菜',
  '辣椒粉',
  '年糕',
  '薑',
  '薏仁',
  '鴨血',
  '鴨胸',
  '龍鬚菜',
  '櫛瓜',
  '薄荷葉',
  '糖',
  '蕃薯粉',
  '醋',
  '豬肉',
  '豬肚',
  '豬血',
  '豌豆',
  '魚露',
  '蔬菜高湯',
  '蔥',
  '蓮藕粉',
  '飯',
  '馬鈴薯',
  '熟地',
  '芝麻',
  '墨魚',
  '廣東粥',
  '鳳梨',
  '酸菜',
  '辣椒',
  '蒜酥',
  '豆芽',
  '紫蘇菜',
  '綜合彩椒',
  '福菜',
  '滷包',
  '榨菜',
  '旗魚',
  '香料',
  '獅子頭',
  '椰子粉',
  '豆皮',
  '黃魚',
  '甜椒',
  '黃耆',
  '菠菜',
  '魚',
  '雪白菇',
  '陳皮',
  '透抽',
  '荸薺',
  '迷迭香',
  '味噌',
  '甜年糕',
  '梅子',
  '斜管面',
  '排骨',
  '培根',
  '米粉',
  '魷魚',
  '乾豆豉',
  '酒',
  '起司',
  '貢丸',
  '草莓',
  '素肉絲',
  '粉絲',
  '中藥滷包',
  '五花肉',
  '豆干',
  '五香粉',
  '五香滷汁',
  '香菜',
  '高湯',
  '月桂葉',
  '毛豆',
  '水梨',
  '火腿',
  '火龍果',
  '牛肉',
  '牛蒡',
  '冬瓜',
  '冬粉',
  '卡士達粉',
  '吐司',
  '可可',
  '可爾必思',
  '可樂',
  '四季豆',
  '海藻糖',
  '海帶',
  '海參',
  '海苔',
  '海瓜子',
  '栗子南瓜',
  '桂圓肉',
  '栗粉',
  '柴魚',
  '原味優格',
  '原味優酪乳',
  '香蕉',
  '柳橙',
  '香草',
  '韭黃',
  '韭菜',
  '茄子',
  '美奶滋',
  '櫻桃',
  '紅豆',
  '秋葵',
  '珊瑚菇',
  '柳松菇',
  '枸杞',
  '春捲皮',
  '扁魚乾',
  '厚肉',
  '南瓜',
  '青醬',
  '青椒',
  '碗豆',
  '木瓜',
  '糯米',
  '長豆',
  '金針菇',
  '金針段',
  '芹菜',
  '花椒',
  '花枝',
  '肥肉丁',
  '空心菜',
  '泡打粉',
  '茶葉',
  '果凍粉',
  '松子',
  '明太子',
  '味醂',
  '咖哩',
  '味精',
  '乳酪',
  '里肌肉',
  '肉羹',
  '豆輪',
  '豆豉',
  '豆包',
  '芋頭',
  '秀珍菇',
  '沙茶醬',
  '杏鮑菇',
  '杏仁',
  '吻仔魚',
  '吳郭魚',
  '何首烏',
  '西瓜',
  '肉',
  '肉桂',
  '羊肉',
  '百香果',
  '百里香',
  '地瓜',
  '地瓜葉',
  '冰',
  '甘蔗',
  '甘草',
  '布蕾粉',
  '玉米',
  '玉米筍',
];
List<Map<String, dynamic>> recipeData = []; // 食譜的 List
class recipesearch extends StatefulWidget {
  const recipesearch({Key? key}) : super(key: key);

  @override
  State<recipesearch> createState() => _recipesearchState();
}

class _recipesearchState extends State<recipesearch> {
  var controller = Get.put(SelectedListController());
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    print("離開食譜查詢");
    super.dispose();
  }
  //此openFilterDialog用來篩選食材
  void openFilterDialog(context) async{
    await FilterListDialog.display<String>(context,
        listData: defaultList,
        selectedListData: controller.getSelectedList(),
        headlineText: '篩選食材',
        //applyButtonText: TextStyle(fontSize: 20),
        choiceChipLabel: (String? item)=> item,
        validateSelectedItem: (list, val)=>list!.contains(val),
        onItemSearch: (list, text){
          return list.toLowerCase().contains(text.toLowerCase());
        },
        onApplyButtonClick: (list){
          setState(() {
            controller.setSelectedList(List<String>.from(list!));
          });
          Navigator.pop(context);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('recipes')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else{
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
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                //外部間距
                                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                //外部間距
                                padding:
                                EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                width: size.width / 1.4,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE9EEF1),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 10),
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
                                        onSubmitted: (_){
                                          print("開始搜尋食譜1：$myController.text");
                                          SearchRecipe(myController.text);
                                          recipe_title_text(
                                            size: size,
                                            title: SrecipeData.map((recipe) => recipe['title'] as String).toList(),
                                            text: SrecipeData.map((recipe) => recipe['text'] as String).toList(),
                                            imagepath: SrecipeData.map((recipe) => recipe['imagepath'] as String).toList(),
                                            step: SrecipeData.map((recipe) => recipe['step'] as String).toList(),

                                            press: () {},
                                            liked: recipeData.map((recipe) => recipe['liked'] as bool).toList(),
                                          );

                                        },
                                        decoration: InputDecoration(
                                          hintText: "Search",
                                          hintStyle: TextStyle(
                                            color: kPrimaryColor.withOpacity(0.5),
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

                                        print("開始搜尋食譜2：$myController.text");
                                        SearchRecipe(myController.text);
                                        recipe_title_text(
                                          size: size,
                                          title: SrecipeData.map((recipe) => recipe['title'] as String).toList(),
                                          text: SrecipeData.map((recipe) => recipe['text'] as String).toList(),
                                          imagepath: SrecipeData.map((recipe) => recipe['imagepath'] as String).toList(),
                                          step: SrecipeData.map((recipe) => recipe['step'] as String).toList(),

                                          press: () {},
                                          liked: recipeData.map((recipe) => recipe['liked'] as bool).toList(),
                                        );

                                      },
                                      icon:Image.asset('assets/icons/search.png'),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: CircleAvatar(
                                    backgroundColor: Color(0xFFE9EEF1),
                                    child: IconButton(
                                        onPressed: () =>openFilterDialog(context),
                                        icon: Image.asset('assets/icons/filter.png'))),
                              ),
                            ],
                          ),
                          //foodmanager(),
                        ],
                      ),
                    ),

                    //controller.getSelectedList()=dialog裡有沒有選東西null就顯示"沒結果"(Center(child: Text('沒有搜尋結果')))or預設食譜
                    //有就用 controller.getSelectedList()![index] 取裡面的東西
                    controller.getSelectedList() == null || controller.getSelectedList()!.length == 0
                        ? Column(
                      children: [
                        Container(
                          width: size.width,
                          margin: const EdgeInsets.only(left: kDefaultPadding),
                          child: Text(
                            "推薦食譜",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //getRecipe(),
                        recipe_title_text(
                          size: size,
                          title: recipeData.map((recipe) => recipe['title'] as String).toList(),
                          text: recipeData.map((recipe) => recipe['text'] as String).toList(),
                          imagepath: recipeData.map((recipe) => recipe['imagepath'] as String).toList(),
                          step: recipeData.map((recipe) => recipe['step'] as String).toList(),
                          press: () {},
                          liked: recipeData.map((recipe) => recipe['liked'] as bool).toList(),
                          // liked: [false,false,false,false],
                        ),
                      ],
                    )
                        : recipe_title_text(
                      size: size,
                      title:
                      controller.getSelectedList(),
                      text: [
                        "蒜頭、培根、蘑菇、鮮奶油、義大利麵、黑胡椒、雞蛋",
                        "薑、雞腿肉、剝皮辣椒罐頭、蛤蜊、米酒",
                        "玉米、鮮奶、雞蛋、紅蘿蔔",
                        "雞翅、菇類、薑、八角、鹽、料理酒、乾香菇、大蔥、乾辣椒、醬油、糖、油",
                      ],
                      imagepath: [
                        "https://i.im.ge/2023/05/14/URFbIT.image.png",
                        "https://i.im.ge/2023/05/14/URFE5r.image.png",
                        "https://i.im.ge/2023/05/14/URFwEq.image.png",
                        "https://i.im.ge/2023/05/14/URFVrJ.image.png",
                      ],
                      step: [
                        "把全部食材丟進鍋裡",
                        "把剝皮辣椒罐頭倒進鍋裡",
                        "把火腿切成丁",
                        "把小雞脫毛",
                      ],
                      press: () {},
                      liked: [false,false,false,false],
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                alignment: Alignment.center,
                child: Text(
                  'no recipe...',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
          }
      }
    );
  }
}

List<Map<String, dynamic>> ShpList = [];
class shoppinglist extends StatefulWidget {
  const shoppinglist({
    Key? key,
  }) : super(key: key);

  @override
  State<shoppinglist> createState() => _shoppinglistState();
}

class _shoppinglistState extends State<shoppinglist> {
  @override
  Widget build(BuildContext context) {
    return  list_checkbox();
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
  TextEditingController controller=TextEditingController();
  String name = '';
  List<Map> categories = [
    //將資料庫裡的資料先放進來
    /*{"title": "蘋果", "isChecked": false},*/
  ];
  @override
  void inidState() {
    super.initState();
  }

  @override
  void dispose() {
    print('購物清單的dispose方法(離開)');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('shplist')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );else{
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
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    gett(),

                    //新增名稱按鈕
                    CircleAvatar(
                        backgroundColor: Colors.grey[200],
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
                              });
                            },
                            icon: Image.asset("assets/icons/plus.png"))),


                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: getSh(
                        title : ShpList.map((shp) => shp['title'] as String).toList(),
                        isChecked: ShpList.map((shp) => shp['isChecked'] as bool).toList(),
                      ),

                    ),
                  ],
                ),
              );
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
          }
      }
    );
  }

  Future<String?> openDialog(BuildContext context) => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("新增物品"),
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
            onSubmitted: (_){
              //此處新增進資料庫：食材名稱的變數為controller.text
              Navigator.of(context).pop(controller.text);
              controller.clear();
              //submit();
            },
            onChanged: (text) {
              print('食材名稱: $text');
            },
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () =>submit(),
            child: Text("取消")),
        TextButton(onPressed: (){
          //此處新增進去資料庫
          Navigator.of(context).pop(controller.text);
          controller.clear();
        }, child: Text("新增")),
      ],
    ),
  );
  void submit() {
    Navigator.pop(context);
    controller.clear();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void createNewShpDocument() async {
    String shpId = firestore
        .collection('shplist')
        .doc()
        .id;

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

