import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/spot.dart';
import '../services/database.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/error_message.dart';
import 'create_qr.dart';

class AddMachine extends HookWidget {
  static const routeName = '/add_machine';
  const AddMachine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _nameController = useTextEditingController();
    final _nameErrorMessage = useState<String>('');
    final _validityName = useState<bool>(true);

    final _addressController = useTextEditingController();
    final _addressErrorMessage = useState<String>('');
    final _validityAddress = useState<bool>(true);

    final _type = useState<String>('Asset Type');

    final _spotId = useState<String>('');

    bool _isValidName(String name) {
      if (name.length < 3) {
        _nameErrorMessage.value = 'Name too short';
        _validityName.value = false;
        return false;
      } else {
        _validityName.value = true;
        return true;
      }
    }

    bool _isValidAddress(String address) {
      if (address.length < 3) {
        _addressErrorMessage.value = 'address too short';
        _validityAddress.value = false;
        return false;
      } else {
        _validityAddress.value = true;
        return true;
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: 'Add Asset',
        ),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextField(
                controller: _nameController,
                title: 'Name',
                validity: _validityName.value,
                errorMessage: _nameErrorMessage.value,
                obscureText: false,
                iconData: FontAwesomeIcons.solidUser,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _addressController,
                title: 'Address',
                validity: _validityAddress.value,
                errorMessage: _addressErrorMessage.value,
                obscureText: false,
                iconData: FontAwesomeIcons.addressBook,
              ),
              const SizedBox(height: 20),
              CustomDropdown(
                hint: _type.value,
                list: const ['Fire Extinguisher', 'Water Sprinklr'],
                iconData: FontAwesomeIcons.tools,
                onChanged: (String val) {
                  _type.value = val;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "List of Sites",
                textScaleFactor: 1.4,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
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
                            return ListTile(
                              onTap: () => _spotId.value = spot.id,
                              hoverColor: Theme.of(context).accentColor,
                              leading: _spotId.value == spot.id
                                  ? Icon(
                                      FontAwesomeIcons.check,
                                      color: Theme.of(context).accentColor,
                                    )
                                  : null,
                              title: Text(
                                spot.name,
                                textScaleFactor: 1.2,
                              ),
                              trailing: Text(
                                spot.machineId.length.toString(),
                                textScaleFactor: 1.2,
                              ),
                            );
                          },
                          itemCount: snapshot.data.length as int,
                        );
                      } else {
                        return const Center(
                          child: ErrorMessage(
                            message: 'No Site available',
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
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          if (_isValidName(_nameController.text.trim()) &&
              _isValidAddress(_addressController.text.trim()) &&
              _type.value != 'Asset Type' &&
              _spotId.value != '') {
            try {
              final String id = await DatabaseService.createMachines(
                name: _nameController.text.trim(),
                address: _addressController.text.trim(),
                type: _type.value,
                spotId: _spotId.value,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<ShowBarcode>(
                  builder: (context) => ShowBarcode(
                    data: id,
                  ),
                ),
              );
            } catch (e) {
              debugPrint(e.toString());
            }
          }
        },
        style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Add Machine"),
        ),
      ),
    );
  }
}
