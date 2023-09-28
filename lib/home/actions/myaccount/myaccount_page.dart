import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../colors.dart';

class MyaccountPage extends StatelessWidget {
  const MyaccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
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
          '我的帳號',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: kDefaultPadding,right: kDefaultPadding),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    user.photoURL != null
                        ? Image.network("${user.photoURL}")
                        : Container(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        user.displayName != null
                            ? Text(
                                "${user.displayName}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: kTextColor,
                                  decoration: TextDecoration.none,
                                ),
                              )
                            : Container(
                                child: Text("No account"),
                              ),
                        user.email != null
                            ? Text(
                                "${user.email}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kTextColor,
                                  decoration: TextDecoration.none,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
