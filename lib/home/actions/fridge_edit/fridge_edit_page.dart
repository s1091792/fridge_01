import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/home/components/set_Button.dart';

import '../../../colors.dart';

class FridgesPage extends StatefulWidget {
  const FridgesPage({Key? key}) : super(key: key);

  @override
  State<FridgesPage> createState() => _FridgesPageState();
}

class _FridgesPageState extends State<FridgesPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: kHomeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:IconButton(
          icon: Image.asset("assets/icons/back.png"),
          onPressed: (){
            Navigator.pop(context);
          },
        ) ,
        title: const Text('冰箱編輯',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,
          fontSize: 30,),),
      ),
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              firdge_edit_card(size: size, title: "我家的冰箱", pressedit: (){}, pressdelete: (){},kFridgeColor: Colors.blueGrey,),
              //新的冰箱架構(firdge_edit_card)放這
            ],
          ),
        ),
      ),
    );
  }
}

class firdge_edit_card extends StatelessWidget {
  const firdge_edit_card({
    super.key,
    required this.size, required this.title, required this.pressedit,required this.pressdelete, required this.kFridgeColor,
  });
  final String title;
  final Function() pressedit,pressdelete;
  final Size size;
  final Color kFridgeColor;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Column(
      children: [
        SizedBox(height: kDefaultPadding),
        GestureDetector(
          onTap: pressedit,
          child: Container(
            padding:  const EdgeInsets.only(left: kDefaultPadding,top: 10,bottom: 10),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            /*decoration: BoxDecoration(
      color: Colors.grey[200],
      elevation: 0,
    ),*/
            child: Center(
              child: Row(
                children: <Widget>[
                  Text(
                ' ${user.displayName}的冰箱',
                    style: TextStyle(
                      //color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  IconButton(
                    onPressed:(){},
                    icon: Image.asset("assets/icons/edit.png"),
                  ),
                  SizedBox(width: 20,),
                ],
              ),
            ),
          ),
        ),
    Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding/2,
        bottom: kDefaultPadding /2,
      ),
      //總寬渡40%
      //width: size.width * 0.4,
      height: size.width*0.4,
      child: Row(
        children: <Widget>[
          Text("顏色：",style: TextStyle(fontSize: 30),),
          //冰箱顏色
          Container(width: size.width*0.2,height: size.width*0.2,color: kFridgeColor,),
          //Image.asset('assets/images/greengirl-sheet0.png'),
          GestureDetector(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                boxShadow:[
                  BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: pressdelete,//(){showDialog(context: context, builder: builder)},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  //框寬度 side: BorderSide(width: 3, color: Colors.black),
                ),
              ),
            ),

            child: Text(
              "刪除冰箱",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ),
      ],
    );
  }
}
