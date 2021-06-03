import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/body_container.dart';
import '../services/auth.dart';
import '../widgets/custom_textfield.dart';

class ForgotPassword extends HookWidget {
  static const routeName = '/forgotPassword';

  @override
  Widget build(BuildContext context) {
    final _emailController = useTextEditingController();

    final _validityEmail = useState<bool>(true);

    final _emailIdErrorMessage = useState<String>('');

    final _isLoading = useState<bool>(false);
    final _auth = useProvider(authProvider);

    Future<void> _resetPassword(BuildContext context) async {
      try {
        _isLoading.value = true;
        await _auth.resetPassword(email: _emailController.text.trim());

        //   _scaffoldKey.currentState.showSnackBar(const SnackBar(
        //       content: Text('Password Reset Mail sent successfully')));

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } on FirebaseAuthException catch (e) {
        _validityEmail.value = false;
        _emailIdErrorMessage.value = e.message.toString();
      } finally {
        _isLoading.value = false;
      }
    }

    Text _greetings() {
      return const Text(
        'Forgot Password?',
        textScaleFactor: 2.3,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }

    Column _inputForm() {
      return Column(
        children: [
          CustomTextField(
            controller: _emailController,
            title: 'Email',
            validity: _validityEmail.value,
            errorMessage: _emailIdErrorMessage.value,
            obscureText: false,
            iconData: FontAwesomeIcons.solidEnvelope,
          ),
          const SizedBox(height: 20),
        ],
      );
    }

    bool _isValidEmail(String email) {
      const String p =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      final RegExp regExp = RegExp(p);
      if (email.isEmpty) {
        //assigning error message to String variable emailIdErrorMessage
        _emailIdErrorMessage.value = 'Please enter a Email-id';
        return false;
      } else if (!regExp.hasMatch(email)) {
        //assigning error message to String variable emailIdErrorMessage
        _emailIdErrorMessage.value = 'Please enter a valid Email Address';
        return false;
      } else {
        return true;
      }
    }

    Padding _signInButton(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: MaterialButton(
          height: MediaQuery.of(context).size.height * 0.08,
          minWidth: MediaQuery.of(context).size.width,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () async {
            _validityEmail.value = _isValidEmail(_emailController.text.trim());
            if (_validityEmail.value) {
              await _resetPassword(context);
            }
          },
          color: Theme.of(context).accentColor,
          child: const Text(
            'Reset Passowrd!',
            textScaleFactor: 1.4,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    Widget _logo(BuildContext context) {
      return Container(
        margin: const EdgeInsets.only(top: 50.0, bottom: 30.0),
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
      );
    }

    return Scaffold(
      body: BodyContainer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _logo(context),
              _greetings(),
              const SizedBox(height: 20.0),
              _inputForm(),
              const SizedBox(height: 5.0),
              _signInButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
