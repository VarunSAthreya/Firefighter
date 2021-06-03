import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBar({
    required this.title,
    this.leading,
    this.actions,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: leading ??
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                FontAwesomeIcons.bars,
                size: 30,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
      iconTheme: IconThemeData(color: Theme.of(context).accentColor, size: 30),
      title: Text(
        title,
        textScaleFactor: 1.6,
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: actions ?? [],
    );
  }
}
