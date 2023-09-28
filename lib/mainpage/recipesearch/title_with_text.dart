import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../home/actions/collection/recipe/recipe_page.dart';

class recipe_title_text extends StatefulWidget {
  recipe_title_text({
    super.key,
    required this.title,
    required this.text,
    required this.press, required this.size, required this.imagepath, required this.step,required this.liked,
  });
  final Size size;
  final List<String> title, text,imagepath,step;
  final Function() press;
  late List<bool> liked;

  @override
  State<recipe_title_text> createState() => _recipe_title_textState();
}

class _recipe_title_textState extends State<recipe_title_text> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: widget.size.height-240,
      child: ListView.builder(
          itemCount: widget.title.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(5),
              //width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow:[
                    BoxShadow(
                      offset: Offset(0,10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    '${widget.title[index]}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                    ),
                  ),
                  subtitle: Text(
                    '${widget.text[index]}',
                    style: TextStyle(
                      color: kPrimaryColor.withOpacity(0.5),
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    print('${widget.title[index]}');
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RecipePage(
                          title: '${widget.title[index]}',
                          text: '${widget.text[index]}',
                          imagepath: '${widget.imagepath[index]}',
                          step: '${widget.step[index]}',
                          //liked要調整
                          liked:widget.liked[index], )));
                  },
                ),
              ),
            );
          }),
    );
  }
}