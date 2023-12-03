//參考https://www.youtube.com/watch?v=-PUZ8LrWFWc&list=PLHRVPF7i77EUrMnigmGIcPBLaig_kLna7

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/home/home_page.dart';
import 'package:flutter_app_test/main.dart';
import 'package:flutter_app_test/mainpage/drawer_components/share_fridge/share_page.dart';
import 'package:flutter_app_test/mainpage/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../colors.dart';
import '../../home/actions/collection/collection_page.dart';
import '../../login/bloc_components/auth_bloc.dart';
import '../../notification/notification.dart';
import '../../notification/permission.dart';
import '../../main.dart';

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
    //firebase 通知
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    //firebase剛啟動
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("new notification");
      }
    });
    //偵測app在開啟中
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        listenToNotifications().display("偵測app在開啟中：$message");
      }
    });
    //app在背景但未終止
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("on message opened app");
    });
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
              children: [
                Container(
                  height: 130,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                    color: kPrimaryColor.withOpacity(0.3),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    child: Image.asset(
                      "assets/images/loginlogo.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
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
                          onChanged: (value) async {
                            if (value == true) {
                              bool result = await permissionCheckAndRequest(
                                  context, Permission.notification, "通知");
                              if (result) {
                                //LocalNotifications.initPushNoti();
                                Future.delayed(Duration(milliseconds: 1000),
                                    () {
                                  print("定通知");
                                  LocalNotifications.showPeriodicNotifications(
                                      title: "食材快到期啦",
                                      body: "還有很多食材等你來煮->",
                                      payload: "This is periodic data");
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("開啟通知"),
                                  duration: Duration(seconds: 1),
                                ));
                                LocalNotifications.showScheduleNotification(
                                    title: "已開啟通知",
                                    body: "從現在起每周都會提醒您～",
                                    payload: "This is schedule data");
                              }
                              setState(() {
                                isSwitch = value;
                              });
                            } else {
                              setState(() {
                                isSwitch = value;
                                //listenToNotifications().cancel(1);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("關閉通知"),
                                  duration: Duration(seconds: 1),
                                ));
                              });
                            }
                          }),
                    )
                  ],
                ),
              ],
            ),
            NewRow(
              ontap: () {
                context.read<AuthBloc>().add(SignOutRequested());
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MyApp(),
                    ),
                    ModalRoute.withName('/FirstPage'));
                /*Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                );*/
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
