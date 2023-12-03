import 'package:flutter_app_test/login/login_page.dart';
import 'package:flutter_app_test/login/bloc_components/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/mainpage/drawer_components/drawer_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../colors.dart';
import '../mainpage/main_page.dart';
import 'actions/action_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    /** Getting the user from the FirebaseAuth Instance**/
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      resizeToAvoidBottomInset: false,//不讓畫面因為鍵盤超出頁面
      extendBodyBehindAppBar: true,
      backgroundColor: kHomeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/settings.png'),
            iconSize: 50,
            tooltip: 'settings',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ActionPage()),
              );
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            /**Navigate to the sign in screen when the user Signs Out**/
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
            );
          }
        },
        child: Center(child: fridges(user: user)),
      ),
    );
  }
}

class fridges extends StatelessWidget {
  const fridges({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const Stack(
                      children: [DrawerScreen(), MainScreen()],
                    )),
                  (route) => false,
            );
          },
          icon: Image.asset('assets/images/icecofe.png'),
          iconSize: 400,
        ),
        Text(
          ' ${user.displayName}的冰箱',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
