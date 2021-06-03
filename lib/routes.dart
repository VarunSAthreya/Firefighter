import 'package:flutter/material.dart';

import 'screens/add_machine.dart';
import 'screens/add_request.dart';
import 'screens/add_spot.dart';
import 'screens/forgot_password.dart';
import 'screens/home.dart';
import 'screens/scan_qr.dart';
import 'screens/sign_in.dart';
import 'screens/sign_up.dart';
import 'screens/spot_list.dart';
import 'screens/verify_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignIn.routeName: (context) => SignIn(),
  SignUp.routeName: (context) => SignUp(),
  VerifyScreen.routeName: (context) => VerifyScreen(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
  HomePage.routeName: (context) => HomePage(),
  AddSpot.routeName: (context) => AddSpot(),
  AddMachine.routeName: (context) => AddMachine(),
  AddRequest.routeName: (context) => AddRequest(),
  SpotList.routeName: (context) => SpotList(),
  QRScanPage.routeName: (context) => QRScanPage(),
};
