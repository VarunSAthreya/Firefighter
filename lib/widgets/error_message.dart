import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorMessage extends StatelessWidget {
  final dynamic message;
  const ErrorMessage({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.exclamation,
            size: 100,
            color: Colors.red,
          ),
          const SizedBox(height: 30),
          Text(
            '$message',
            textScaleFactor: 1.2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
