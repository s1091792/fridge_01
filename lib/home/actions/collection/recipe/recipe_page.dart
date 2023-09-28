import 'package:flutter/material.dart';
import 'package:flutter_app_test/colors.dart';

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
                EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${widget.title}",
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
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
                                //放資料庫
                              } else {
                                widget.liked = false;
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
                Container(
                  width: size.width,
                  height: 205,
                  child: Image.network(
                    '${widget.imagepath}',
                  ),
                ),
                Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "食材:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                        Text(
                          "${widget.text}\n",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 26),
                        ),
                        Text(
                          "烹飪方法:\n",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 28),
                        ),
                        Text(
                          "${widget.step}\n",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 26),
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
