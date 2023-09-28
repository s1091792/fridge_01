import 'package:flutter/material.dart';
import 'package:flutter_app_test/home/actions/collection/recipe/recipe_page.dart';

import '../../../colors.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage(
      {Key? key,
      required this.press,})
      : super(key: key);
  final Function() press;
  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {

  //可能先判斷liked為true的進來?因為可能會判斷所以就預設true過去了
  List<String> title=[
    "香蒜奶油培根義大利麵",
    "剝皮辣椒雞湯",
    "玉米濃湯",
    "小雞燉蘑菇",
  ];
  List<String> text= [
  "蒜頭、培根、蘑菇、鮮奶油、義大利麵、黑胡椒、雞蛋",
  "薑、雞腿肉、剝皮辣椒罐頭、蛤蜊、米酒",
  "玉米、鮮奶、雞蛋、紅蘿蔔",
  "雞翅、菇類、薑、八角、鹽、料理酒、乾香菇、大蔥、乾辣椒、醬油、糖、油",
  ];
  List<String> imagepath= [
    "https://i.im.ge/2023/05/14/URFbIT.image.png",
    "https://i.im.ge/2023/05/14/URFE5r.image.png",
    "https://i.im.ge/2023/05/14/URFwEq.image.png",
    "https://i.im.ge/2023/05/14/URFVrJ.image.png",
  ];
  List<String> step= [
    "把全部食材丟進鍋裡",
    "把剝皮辣椒罐頭倒進鍋裡",
    "把火腿切成丁",
    "把小雞脫毛",
  ];
  @override
  Widget build(BuildContext context) {
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
            itemCount: title.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  '${title[index]}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                ),
                onTap: () {
                  print('${title[index]}');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RecipePage(
                        title: '${title[index]}',
                        text: '${text[index]}',
                        imagepath: '${imagepath[index]}',
                        step: '${step[index]}',
                        liked: true, )));
                },
              );
            }),
      ),
    );
  }
}
