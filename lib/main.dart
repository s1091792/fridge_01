import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_test/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app_test/login/login_page.dart';
import 'package:flutter_app_test/home/home_page.dart';
import 'package:flutter_app_test/mainpage/main_page.dart';
// RepositoryProvider & BlocProvider
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login/auth_repository.dart';
import 'login/bloc_components/auth_bloc.dart';

//tips: ctrl+alt+m: extract method;ctrl+alt+w: extract widget;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      //傳訊息到AuthRepository
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          //傳AuthRepository的訊息到AuthBloc
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fridge',
          theme: ThemeData(
            primarySwatch: Colors.grey,
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: kPrimaryColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return HomePage();
                }
                return LoginPage();
              }),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}