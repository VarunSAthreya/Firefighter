import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/request_card.dart';
import '../models/request.dart';
import '../services/database.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/error_message.dart';
import 'add_request.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          title: 'Home',
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AddRequest.routeName),
              icon: const Icon(
                FontAwesomeIcons.plus,
              ),
            )
          ],
        ),
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: StreamBuilder(
          stream: DatabaseService.allRequests,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: ErrorMessage(
                  message: snapshot.error,
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data.length as int > 0) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return RequestCard(
                      request: snapshot.data[index] as Request,
                    );
                  },
                  itemCount: snapshot.data.length as int,
                );
              } else {
                return const Center(
                  child: ErrorMessage(
                    message: 'No request available',
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
