import 'package:firefighter/screens/add_machine.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/add_spot.dart';
import '../screens/home.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 30),
            _logo(context),
            const SizedBox(height: 30),
            _header(context),
            const SizedBox(height: 30),
            _DrawerTile(
              title: 'Home',
              iconData: FontAwesomeIcons.home,
              onTap: () =>
                  Navigator.pushReplacementNamed(context, HomePage.routeName),
            ),
            _DrawerTile(
              title: 'Add Spot',
              iconData: FontAwesomeIcons.plus,
              onTap: () =>
                  Navigator.pushReplacementNamed(context, AddSpot.routeName),
            ),
            _DrawerTile(
              title: 'Add Machine',
              iconData: FontAwesomeIcons.plus,
              onTap: () => Navigator.pushNamed(context, AddMachine.routeName),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logo(BuildContext context) {
    return Image.asset('assets/images/logo.png');
  }

  Center _header(BuildContext context) {
    return Center(
      child: Text(
        'Fire Fighter',
        textAlign: TextAlign.center,
        textScaleFactor: 2.5,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function onTap;

  const _DrawerTile({
    required this.title,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            iconData,
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            title,
            textScaleFactor: 1.3,
          ),
          onTap: () => onTap(),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
