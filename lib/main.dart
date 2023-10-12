import 'package:flutter/material.dart';
import 'package:tourify/CompanyFlow/Company_Login_Authentication/company_login.dart';
import 'package:tourify/CompanyFlow/CompanyHomeScreen/company_homescreen.dart';
import 'package:tourify/HomeScreen.dart';
import 'package:tourify/MainPanel/MainPanel.dart';
import 'package:tourify/user_Auth_login_screens/SignIn.dart';
import 'package:tourify/user_Auth_login_screens/SignUp.dart';
import 'package:tourify/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tourify/CompanyFlow/Company_Login_Authentication/registeration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: const Color(0xff1034A6),
     
    ),
  
    initialRoute: '/',
  
    routes: {
      '/':(context) => const SplashScreen (),
      'HomeScreen':(context) => const HomeScreen (),
      'SignUpScreen':(context) => const SignUpScreen (),
      'SignInScreen':(context) => const SignInScreen (),
      'MainScreen':(context) => const MainScreen (), 
      'CompanyRegistration':(context) => const CompanyRegisteration (),
      'CompanySignInScreen':(context) => const CompanySignIn (),
      'CompanyHomeScreen':(context) => const CompanyHomeScreen (),

    },
  ));
}
