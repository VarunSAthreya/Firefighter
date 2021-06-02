import 'package:flutter/material.dart';

import 'screens/forgot_password.dart';
import 'screens/sign_in.dart';
import 'screens/sign_up.dart';
import 'screens/verify_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignIn.routeName: (context) => SignIn(),
  SignUp.routeName: (context) => SignUp(),
  VerifyScreen.routeName: (context) => VerifyScreen(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
};
