//參考https://www.youtube.com/watch?v=-PUZ8LrWFWc&list=PLHRVPF7i77EUrMnigmGIcPBLaig_kLna7

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/home/home_page.dart';
import 'package:flutter_app_test/main.dart';
import 'package:flutter_app_test/mainpage/drawer_components/share_fridge/share_page.dart';
import 'package:flutter_app_test/mainpage/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../colors.dart';
import '../../home/actions/collection/collection_page.dart';
import '../../login/bloc_components/auth_bloc.dart';
import '../../notification/notification.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isSwitch = false;

  @override
  void initState() {
    super.initState();
    listenToNotifications();
  }

  //監聽通知有沒有被按
  listenToNotifications() {
    print("監聽通知");
    LocalNotifications.onClickNotification.stream.listen((event) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const Stack(
              children: [DrawerScreen(), MainScreen()],
            )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kHomeBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blueGrey[200],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: user.photoURL != null
                        ? Image.network("${user.photoURL}")
                        : Container(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                user.displayName != null
                    ? Text(
                        "${user.displayName}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: kTextColor,
                          decoration: TextDecoration.none,
                        ),
                      )
                    : Container(),
              ],
            ),
            Column(
              children: <Widget>[
                NewRow(
                  ontap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  text: "首頁",
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  ontap: () {
                    //需要pop回來
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CollectionPage(
                          press: () {},
                        ),
                      ),
                    );
                  },
                  text: "我的收藏",
                ),
                SizedBox(
                  height: 20,
                ),
                NewRow(
                  ontap: () {
                    //需要pop回來
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SharePage(),
                      ),
                    );
                  },
                  text: "共享冰箱",
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      '通知',
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                          value: isSwitch,
                          onChanged: (value) {
                            if (value == true) {
                              Future.delayed(Duration(milliseconds: 1000), () {
                                print("開通知");
                              });
                              LocalNotifications.showScheduleNotification(
                                  title: "已開啟通知",
                                  body: "從現在起每周都會提醒您～",
                                  payload: "This is schedule data");
                              LocalNotifications.showPeriodicNotifications(
                                  title: "食材快到期啦",
                                  body: "還有很多食材等你來煮->",
                                  payload: "This is periodic data");
                            }
                            setState(() {
                              isSwitch = value;
                            });
                          }),
                    )
                  ],
                ),
              ],
            ),
            NewRow(
              ontap: () {
                context.read<AuthBloc>().add(SignOutRequested());
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                );
              },
              text: "登出",
            ),
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  const NewRow({
    super.key,
    required this.ontap,
    required this.text,
  });

  final Function() ontap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(
              color: kTextColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
