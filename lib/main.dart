import 'package:flutter/material.dart';
import 'package:tourify/Admin%20Panel/admin_panel.dart';
import 'package:tourify/Admin%20Panel/approved.dart';
import 'package:tourify/CompanyFlow/Company_Login_Authentication/company_login.dart';
import 'package:tourify/CompanyFlow/CompanyHomeScreen/company_homescreen.dart';
import 'package:tourify/HomeScreen.dart';
import 'package:tourify/MainPanel/MainPanel.dart';
import 'package:tourify/machine-learning.dart';
import 'package:tourify/user_Auth_login_screens/SignIn.dart';
import 'package:tourify/user_Auth_login_screens/SignUp.dart';
import 'package:tourify/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tourify/CompanyFlow/Company_Login_Authentication/registeration.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:tourify/Admin Panel/pending_request.dart';
import 'package:tourify/maps.dart';


void main() async {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  // Require Hybrid Composition mode on Android.
 
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
      'OfflineMaps':(context) =>     MyWidget(),
      'AdminHome':(context) =>  const AdminHome (),  
      'Pending':(context) =>  Pending (),
      'Approved':(context) => Approved (),

    },
  ));
}
