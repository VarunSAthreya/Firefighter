import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {
  final Widget child;

  const BodyContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).accentColor,
                      Theme.of(context).backgroundColor,
                    ],
                  ),
                ),
                alignment: Alignment.center,
                width: double.infinity,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
