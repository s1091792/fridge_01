import 'package:flutter/material.dart';
import 'package:flutter_app_test/colors.dart';
import 'package:flutter_app_test/mainpage/recipesearch/SearchRecipe.dart';

class RecipePage extends StatefulWidget {
  RecipePage({
    Key? key,
    required this.title,
    required this.liked,
    required this.text,
    required this.imagepath,
    required this.step,
  }) : super(key: key);
  final String title, text, imagepath, step;
  late bool liked;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    print("食材的變動");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.title,
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey[200],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (widget.liked == false) {
                                widget.liked = true;
                                LikedRecipe(widget.title);
                                //放資料庫
                              } else {
                                widget.liked = false;
                                UnLikedRecipe(widget.title);
                                //從資料庫移除喜歡，類似這段?
                              }
                            });
                          },
                          icon: widget.liked
                              ? Image.asset(
                                  "assets/icons/heart.png",
                                )
                              : Image.asset(
                                  "assets/icons/noheart.png",
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 18.0,
                  indent: 0.0,
                  color: Colors.black,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    widget.imagepath,
                    height: 250,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "食材：",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 28,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${widget.text}\n",
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Text(
                          "烹飪方法：\n",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.step}\n",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
