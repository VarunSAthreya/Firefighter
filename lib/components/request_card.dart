import 'package:firefighter/models/request.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../models/request.dart';

class RequestCard extends StatelessWidget {
  final Request request;

  const RequestCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //   onTap: () => Navigator.push<RequestScreen>(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => RequestScreen(Request: Request),
      //     ),
      //   ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 3)],
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              request.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              textScaleFactor: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              request.description,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              textScaleFactor: 1.3,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.clock,
                  color: Theme.of(context).accentColor,
                ),
                const SizedBox(width: 5),
                Text(
                  ' ${dateFormat.format(request.createdAt)}',
                  textScaleFactor: 1.2,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
