import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../constants.dart';
import '../models/machine.dart';
import '../models/request.dart';
import '../models/spot.dart';
import '../models/user.dart';
import '../services/database.dart';
import '../widgets/custom_appbar.dart';

class RequestDetails extends HookWidget {
  final Request request;
  const RequestDetails({required this.request});

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState<bool>(true);
    final endUser = useState<Users?>(null);
    final machine = useState<Machine?>(null);
    final spot = useState<Spot?>(null);
    final placemarks = useState<List<Placemark>?>(null);

    Future<void> getDetails() async {
      endUser.value = await DatabaseService.getUser(id: request.endUserId);
      machine.value = await DatabaseService.getMachine(id: request.machineId);
      spot.value = await DatabaseService.getSpot(id: request.spotId);
      placemarks.value = await placemarkFromCoordinates(
          spot.value!.location.latitude, spot.value!.location.longitude);
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
                      Text(
                        'Spot Name: ${spot.value!.name}',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Spot Address: \n ${placemarks.value![0]}',
                        softWrap: true,
                        textScaleFactor: 1,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Machine Name: ${machine.value!.name}',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Machine type: ${machine.value!.type}',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Machine location: ${machine.value!.address}',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Machine Total services: ${machine.value!.services.length}',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.1,
                      ),
                      if (machine.value!.lastServiced != null) ...[
                        const SizedBox(height: 20),
                        Text(
                          'Machine previous service: ${dateFormat.format(machine.value!.lastServiced!)}',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.2,
                        ),
                      ]
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
