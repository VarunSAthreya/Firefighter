import 'package:firefighter/screens/maps.dart';
import 'package:firefighter/widgets/custom_appbar.dart';
import 'package:firefighter/widgets/custom_drawer.dart';
import 'package:firefighter/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddSpot extends HookWidget {
  static const String routeName = '/add_spot';

  @override
  Widget build(BuildContext context) {
    final _nameController = useTextEditingController();
    final _nameErrorMessage = useState<String>('');
    final _validityName = useState<bool>(true);

    bool _isValidName(String name) {
      if (name.length < 3) {
        _nameErrorMessage.value = 'Name too short';
        return false;
      } else {
        return true;
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: 'Add Spot',
        ),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          if (_isValidName(_nameController.text.trim())) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<MapsLocation>(
                builder: (context) => MapsLocation(
                  spotName: _nameController.text.trim(),
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Select Location"),
        ),
      ),
    );
  }
}
