import 'package:flutter/material.dart';
import 'package:flutter_app_test/home/home_page.dart';
import 'package:flutter_app_test/login/components/my_textfield.dart';
import 'package:flutter_app_test/login/components/my_button.dart';
import 'package:flutter_app_test/login/components/square_tile.dart';
import 'package:flutter_app_test/main.dart';
import 'package:flutter_app_test/mainpage/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_components/auth_bloc.dart';



class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();

  // sign user in method(button)
  //void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,//不讓畫面因為鍵盤超出頁面
      backgroundColor: Color(0xFFF2FBFF),
      body: SafeArea(   //解決靠邊（上、下、左、右）的地方會被遮擋
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              // logo
              Image.asset(
                height: 200,
                width: 200,
                "assets/images/logo.jpg",),
              const SizedBox(height: 15),
              // welcome back, you've been missed!
              Text(
                'Welcome back',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 50,
                ),
              ),

              const SizedBox(height: 15),

              // username textfield
                //sign in button
              const SizedBox(height: 15),
              MyButton(
                string: "with google",
                imagepath: 'assets/images/google.png',
                onTap: (){
                  _authenticateWithGoogle(context);
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
void _authenticateWithGoogle(context) {

  BlocProvider.of<AuthBloc>(context).add(
    GoogleSignInRequested(),
  );
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) =>  const MyApp()));
}