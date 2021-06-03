import 'package:firefighter/screens/spot_details.dart';
import 'package:flutter/material.dart';

import '../models/spot.dart';
import '../services/database.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/error_message.dart';

class SpotList extends StatelessWidget {
  static const routeName = '/spot_list';
  const SpotList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: 'Spot List',
        ),
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: StreamBuilder(
          stream: DatabaseService.allspots,
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
                    final Spot spot = snapshot.data[index] as Spot;
                    return SpotCard(spot: spot);
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

class SpotCard extends StatelessWidget {
  const SpotCard({
    Key? key,
    required this.spot,
  }) : super(key: key);

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<SpotDetails>(
          builder: (context) => SpotDetails(
            spot: spot,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 3)],
        ),
        child: ListTile(
          title: Text(
            spot.name,
            textScaleFactor: 1.5,
          ),
          trailing: Text(
            spot.machineId.length.toString(),
            textScaleFactor: 1.5,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
