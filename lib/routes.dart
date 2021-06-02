import 'package:firefighter/screens/forgot_password.dart';
import 'package:firefighter/screens/sign_in.dart';
import 'package:firefighter/screens/sign_up.dart';
import 'package:firefighter/screens/verify_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SignIn.routeName: (context) => SignIn(),
  SignUp.routeName: (context) => SignUp(),
  VerifyScreen.routeName: (context) => VerifyScreen(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
};
