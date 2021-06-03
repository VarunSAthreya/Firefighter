import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/machine.dart';
import '../models/spot.dart';
import '../services/database.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/error_message.dart';
import 'home.dart';

class AddRequest extends HookWidget {
  static const routeName = '/add_request';
  const AddRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _titleController = useTextEditingController();
    final _titleErrorMessage = useState<String>('');
    final _validityTitle = useState<bool>(true);

    final _descriptionController = useTextEditingController();
    final _descriptionErrorMessage = useState<String>('');
    final _validityDescription = useState<bool>(true);

    final _spotId = useState<String>('');
    final _machineId = useState<String>('');

    bool _isValidTitle(String name) {
      if (name.length < 3) {
        _titleErrorMessage.value = 'Title too short';
        _validityTitle.value = false;
        return false;
      } else {
        _validityTitle.value = true;
        return true;
      }
    }

    bool _isValidDescription(String description) {
      if (description.length < 3) {
        _descriptionErrorMessage.value = 'Description too short';
        _validityDescription.value = false;
        return false;
      } else {
        _validityDescription.value = true;
        return true;
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: 'Add Request',
        ),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextField(
                controller: _titleController,
                title: 'Title',
                validity: _validityTitle.value,
                errorMessage: _titleErrorMessage.value,
                obscureText: false,
                iconData: FontAwesomeIcons.font,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _descriptionController,
                title: 'Description',
                validity: _validityDescription.value,
                errorMessage: _descriptionErrorMessage.value,
                obscureText: false,
                iconData: FontAwesomeIcons.bars,
              ),
              const SizedBox(height: 20),
              const Text(
                "List of Spots",
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
              if (_spotId.value != '') ...[
                const SizedBox(height: 20),
                const Text(
                  "List of Machines",
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
                    stream:
                        DatabaseService.getSpotMachines(spotId: _spotId.value),
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
                              final Machine machine =
                                  snapshot.data[index] as Machine;
                              return ListTile(
                                onTap: () => _machineId.value = machine.id,
                                leading: _machineId.value == machine.id
                                    ? Icon(
                                        FontAwesomeIcons.check,
                                        color: Theme.of(context).accentColor,
                                      )
                                    : null,
                                title: Text(
                                  machine.name,
                                  textScaleFactor: 1.2,
                                ),
                                trailing: Text(
                                  machine.type,
                                  textScaleFactor: 1.2,
                                ),
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
              ]
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          if (_isValidTitle(_titleController.text.trim()) &&
              _isValidDescription(_descriptionController.text.trim()) &&
              _machineId.value != '' &&
              _spotId.value != '') {
            try {
              await DatabaseService.createRequest(
                machineId: _machineId.value,
                endUserId: FirebaseAuth.instance.currentUser!.uid,
                spotId: _spotId.value,
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim(),
              );
              Navigator.pushReplacementNamed(context, HomePage.routeName);
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
