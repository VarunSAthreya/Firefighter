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
import '../widgets/error_message.dart';
import 'home.dart';

class RequestDetails extends HookWidget {
  final Request request;
  const RequestDetails({required this.request});

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState<bool>(true);
    final machine = useState<Machine?>(null);
    final spot = useState<Spot?>(null);
    final assigned = useState<Users?>(null);
    final placemarks = useState<List<Placemark>?>(null);

    final _isAssigning = useState<bool>(false);
    final _engineerId = useState<String>('');

    Future<void> getDetails() async {
      machine.value = await DatabaseService.getMachine(id: request.machineId);
      spot.value = await DatabaseService.getSpot(id: request.spotId);
      placemarks.value = await placemarkFromCoordinates(
          spot.value!.location.latitude, spot.value!.location.longitude);
      if (request.assignedTo != null) {
        assigned.value = await DatabaseService.getUser(id: request.assignedTo!);
      }
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
                      ],
                      if (request.assignedTo != null) ...[
                        const SizedBox(height: 20),
                        Text(
                          'Assigned Engineer:\n\t\t${assigned.value!.name}',
                          softWrap: true,
                          textScaleFactor: 1.1,
                        ),
                      ],
                      if (request.assignedTo == null &&
                          !_isAssigning.value) ...[
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _isAssigning.value = true,
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).accentColor),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Assign Work"),
                          ),
                        ),
                      ],
                      if (_isAssigning.value) ...[
                        const SizedBox(height: 20),
                        const Text(
                          "List of Engineers",
                          textScaleFactor: 1.4,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: StreamBuilder(
                            stream: DatabaseService.engineers,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
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
                                      final Users user =
                                          snapshot.data[index] as Users;
                                      return ListTile(
                                        onTap: () =>
                                            _engineerId.value = user.id,
                                        hoverColor:
                                            Theme.of(context).accentColor,
                                        leading: _engineerId.value == user.id
                                            ? Icon(
                                                FontAwesomeIcons.check,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              )
                                            : null,
                                        title: Text(
                                          user.name,
                                          textScaleFactor: 1.2,
                                        ),
                                        trailing: Text(
                                          user.actions.length.toString(),
                                          textScaleFactor: 1.2,
                                        ),
                                      );
                                    },
                                    itemCount: snapshot.data.length as int,
                                  );
                                } else {
                                  return const Center(
                                    child: ErrorMessage(
                                      message: 'No engineers available',
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
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              if (_engineerId.value != '') {
                                await DatabaseService.assignRequest(
                                  id: request.id,
                                  uid: _engineerId.value,
                                );
                              }
                              Navigator.pushReplacementNamed(
                                  context, HomePage.routeName);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).accentColor),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Assign Them"),
                          ),
                        ),
                      ],
                      if (!request.isSolved) ...[
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await DatabaseService.finishRequest(
                                id: request.id,
                                uid: request.assignedTo.toString(),
                              );
                              Navigator.pushReplacementNamed(
                                  context, HomePage.routeName);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).accentColor),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Work Done?!"),
                          ),
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
