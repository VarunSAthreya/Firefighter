import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../models/machine.dart';
import '../models/spot.dart';
import '../services/database.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/error_message.dart';
import 'machine_details.dart';

class SpotDetails extends HookWidget {
  final Spot spot;
  const SpotDetails({Key? key, required this.spot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState(true);
    final placemarks = useState<List<Placemark>?>(null);

    Future<void> getLocation() async {
      placemarks.value = await placemarkFromCoordinates(
          spot.location.latitude, spot.location.longitude);
      _isLoading.value = false;
    }

    useEffect(() {
      getLocation();
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
          title: 'Spot',
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
                        spot.name,
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
                        'Number of Machines ${spot.machineId.length}',
                        softWrap: true,
                        textScaleFactor: 1.2,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Address: \n ${placemarks.value![0]}',
                        softWrap: true,
                        textScaleFactor: 1,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "List of Machines",
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
                          stream:
                              DatabaseService.getSpotMachines(spotId: spot.id),
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
                                    final Machine machine =
                                        snapshot.data[index] as Machine;
                                    return MachineCard(
                                      machine: machine,
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
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class MachineCard extends StatelessWidget {
  const MachineCard({
    Key? key,
    required this.machine,
  }) : super(key: key);

  final Machine machine;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute<MachineDetails>(
          builder: (context) => MachineDetails(
            machine: machine,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(
            machine.name,
            textScaleFactor: 1.1,
          ),
          trailing: Text(
            machine.type,
            textScaleFactor: 1.1,
          ),
        ),
      ),
    );
  }
}
