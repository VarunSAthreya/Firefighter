import 'package:firefighter/screens/add_service.dart';
import 'package:firefighter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../models/machine.dart';
import '../models/spot.dart';
import '../widgets/custom_appbar.dart';
import 'create_qr.dart';

class MachineDetails extends HookWidget {
  final Machine machine;
  const MachineDetails({
    Key? key,
    required this.machine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState(true);
    final spot = useState<Spot?>(null);

    Future<void> getSpot() async {
      spot.value = await DatabaseService.getSpot(id: machine.spotId);
      _isLoading.value = false;
    }

    useEffect(() {
      getSpot();
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
          title: 'Machine',
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
                        machine.name,
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
                        'Spot: ${spot.value!.name}',
                        softWrap: true,
                        textScaleFactor: 1.2,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Relative location: ${machine.address}',
                        softWrap: true,
                        textScaleFactor: 1.2,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Type: ${machine.type}',
                        softWrap: true,
                        textScaleFactor: 1.2,
                      ),
                      const SizedBox(height: 20),
                      if (machine.lastServiced != null) ...[
                        Text(
                          'Last Serviced: ${dateFormat.format(machine.lastServiced!)}',
                          softWrap: true,
                          textScaleFactor: 1.2,
                        ),
                        const SizedBox(height: 20),
                      ],
                      if (machine.futureService != null) ...[
                        Text(
                          'Next Service Date: ${dateFormat.format(machine.futureService!)}',
                          softWrap: true,
                          textScaleFactor: 1.2,
                        ),
                        const SizedBox(height: 20),
                      ],
                      Text(
                        'Total Services: ${machine.services.length}',
                        softWrap: true,
                        textScaleFactor: 1.2,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute<ShowBarcode>(
                            builder: (context) => ShowBarcode(
                              data: machine.id,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).accentColor),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Check QR code"),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute<AddService>(
                            builder: (context) => AddService(
                              machine: machine,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).accentColor),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Start Service"),
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
