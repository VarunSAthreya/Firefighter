import 'package:flutter/material.dart';

import 'screens/forgot_password.dart';
import 'screens/home.dart';
import 'screens/maps.dart';
import 'screens/sign_in.dart';
import 'screens/sign_up.dart';
import 'screens/verify_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignIn.routeName: (context) => SignIn(),
  SignUp.routeName: (context) => SignUp(),
  VerifyScreen.routeName: (context) => VerifyScreen(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
  HomePage.routeName: (context) => HomePage(),
  MapsLocation.routeName: (context) => MapsLocation(),
};
