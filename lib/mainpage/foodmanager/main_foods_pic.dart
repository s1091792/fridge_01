import 'package:flutter/material.dart';
import 'package:flutter_app_test/colors.dart';

class seven_food_pic extends StatefulWidget {
  const seven_food_pic({
    super.key,  required this.title, required this.date, required this.number, required this.press, required this.image,
  });
  final List<String>  title, date;
  final List<int> number;
  final Function() press;
  final List<String> image;
  @override
  State<seven_food_pic> createState() => _seven_food_picState();
}

class _seven_food_picState extends State<seven_food_pic> {

  @override
  Widget build(BuildContext context) {
    Future<String?> openDialog(BuildContext context,String name,) => showDialog<String>(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 190),
        child: AlertDialog(
          title: Text("！！",style: TextStyle(fontSize: 30,color: Colors.red),),
          content: Column(
            children: [
              Text("確定要刪除${name}嗎?",style: TextStyle(fontSize: 20,),),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("取消")),
            TextButton(onPressed: (){
            }, child: Text("確認")),
          ],
        ),
      ),
    );
    return Container(
      width: double.maxFinite,
      height:182,
      child: ListView.builder(
          itemCount: widget.title.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onLongPress: (){
                openDialog(context,widget.title[index]);
              },
              child: Container(
                margin:const EdgeInsets.only(left: kDefaultPadding-5,top: 10),
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child:Column(
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
                        boxShadow:[
                          BoxShadow(
                            offset: Offset(0,10),
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
                                    text: " ${widget.title[index]}\n".toUpperCase(),
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
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
}

/*class OldView extends StatelessWidget {
  const OldView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          food_card(
            image: 'https://picsum.photos/250?image=9',
            title: "apple",
            country: "fridge",
            price: 100,
            press: (){},
          ),
          food_card(
            image: 'https://picsum.photos/250?image=9',
            title: "apple",
            country: "fridge",
            price: 100,
            press: (){},
          ),
          food_card(
            image: 'https://picsum.photos/250?image=9',
            title: "apple",
            country: "fridge",
            price: 100,
            press: (){},
          ),
        ],
      ),
    );
  }
}

class food_card extends StatefulWidget {
  const food_card({
    super.key, required this.image, required this.title, required this.country, required this.price, required this.press,
  });

  final String image, title, country;
  final int price;
  final Function() press;

  @override
  State<food_card> createState() => _food_cardState();
}

class _food_cardState extends State<food_card> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding/2,
        bottom: kDefaultPadding /2,
      ),
      //總寬渡40%
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[

          FadeInImage.assetNetwork(

            image: widget.image,
            placeholder: 'assets/images/icecofe.png',
          ),
          Container(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow:[
                BoxShadow(
                  offset: Offset(0,10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${widget.title}\n".toUpperCase(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      TextSpan(
                        text: "${widget.country}".toUpperCase(),
                        style: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  '${widget.price}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/