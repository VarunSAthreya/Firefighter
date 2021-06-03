import 'package:firefighter/models/machine.dart';
import 'package:firefighter/models/spot.dart';
import 'package:firefighter/models/user.dart';
import 'package:firefighter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../models/request.dart';
import '../widgets/custom_appbar.dart';

class RequestDetails extends HookWidget {
  final Request request;
  const RequestDetails({required this.request});

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState<bool>(true);
    late final Users endUser;
    late final Machine machine;
    late final Spot spot;

    Future<void> getDetails() async {
      endUser = await DatabaseService.getUser(id: request.endUserId);
      machine = await DatabaseService.getMachine(id: request.machineId);
      spot = await DatabaseService.getSpot(id: request.spotId);
      _isLoading.value = false;
    }

    useEffect(() {
      getDetails();
    }, []);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          leading: IconButton(
            icon: const Icon(
              FontAwesomeIcons.chevronLeft,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: 'Request',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
        child: _isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 20),
                      Text(
                        'Date: ${dateFormat.format(request.createdAt)}',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        request.description,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.4,
                      ),
                      const SizedBox(height: 20),
                      //   TODO: display spot and other details
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
