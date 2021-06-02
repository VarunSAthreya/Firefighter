import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'routes.dart';
import 'screens/sign_in.dart';
import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light),
  );

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackwell',
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: const Color(0xFFFF4448),
        backgroundColor: const Color(0xFFEEEEEE),
        fontFamily: 'Mont-med',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  final authStateProvider =
      StreamProvider((ref) => ref.watch(authProvider).authStateChanges);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _authState = watch(authStateProvider);
    return _authState.when(
      data: (value) {
        return value != null
            ? SignIn() //const SplashScreen(routeName: HomeScreen.routeName)
            : SignIn();
      },
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (_, __) {
        return const Scaffold(
          body: Center(
            child: Text('Unexpected error occurred'),
          ),
        );
      },
    );
  }
}
