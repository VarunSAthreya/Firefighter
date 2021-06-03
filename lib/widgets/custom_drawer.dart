import 'package:firefighter/screens/scan_qr.dart';
import 'package:firefighter/screens/sign_in.dart';
import 'package:firefighter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screens/add_machine.dart';
import '../screens/home.dart';
import '../screens/spot_list.dart';

class CustomDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = useProvider(authProvider);
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
              title: 'All Spots',
              iconData: FontAwesomeIcons.locationArrow,
              onTap: () => Navigator.pushNamed(context, SpotList.routeName),
            ),
            _DrawerTile(
              title: 'Add Machine',
              iconData: FontAwesomeIcons.plus,
              onTap: () => Navigator.pushNamed(context, AddMachine.routeName),
            ),
            _DrawerTile(
              title: 'Scan QR',
              iconData: FontAwesomeIcons.qrcode,
              onTap: () => Navigator.pushNamed(context, QRScanPage.routeName),
            ),
            _DrawerTile(
              title: 'Log Out',
              iconData: FontAwesomeIcons.signOutAlt,
              onTap: () {
                _auth.signOut();
                Navigator.pushReplacementNamed(context, SignIn.routeName);
              },
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
