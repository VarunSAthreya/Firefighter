import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants.dart';
import '../models/machine.dart';
import '../providers/image_provider.dart';
import '../screens/home.dart';
import '../services/database.dart';
import '../services/storage.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';

class AddService extends HookWidget {
  final Machine machine;

  const AddService({
    Key? key,
    required this.machine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLoading = useState<bool>(false);
    final _poster1 = useState<File?>(null);
    final _poster2 = useState<File?>(null);
    final _date = useState(DateTime.now());
    final imagePicker = useProvider(imageProvider);
    final choosenDate = useState('Pick Date');

    Future<void> _pickImage1() async {
      _isLoading.value = true;
      try {
        _poster1.value = await imagePicker.pickImage();
        debugPrint('Sccessfull ${_poster1.value!.path}');
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        _isLoading.value = false;
      }
    }

    Future<void> _pickImage2() async {
      _isLoading.value = true;
      try {
        _poster2.value = await imagePicker.pickImage();
        debugPrint('Sccessfull ${_poster2.value!.path}');
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        _isLoading.value = false;
      }
    }

    Future<void> _pickDate(String type) async {
      final DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: DateTime.now(),
      );
      if (date != null) {
        _date.value = date;
        choosenDate.value = dateFormat.format(date);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          title: 'Service Asset',
        ),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                        const InputText(title: 'Service Image'),
                        ListTile(
                          title: const Text('Before service'),
                          trailing: const Icon(FontAwesomeIcons.chevronDown),
                          onTap: () => _pickImage1(),
                        ),
                        ListTile(
                          title: const Text('After service'),
                          trailing: const Icon(FontAwesomeIcons.chevronDown),
                          onTap: () => _pickImage2(),
                        ),
                        const SizedBox(height: 20),
                        const InputText(title: 'Expected Next Service Date'),
                        ListTile(
                          title: Text(choosenDate.value),
                          trailing: const Icon(FontAwesomeIcons.chevronDown),
                          onTap: () => _pickDate('event'),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          try {
            final url1 = await StorageService(
                    userId: FirebaseAuth.instance.currentUser!.uid)
                .uploadImage(file: _poster1.value!);
            final url2 = await StorageService(
                    userId: FirebaseAuth.instance.currentUser!.uid)
                .uploadImage(file: _poster2.value!);

            await DatabaseService.createService(
              machineId: machine.id,
              engineerId: FirebaseAuth.instance.currentUser!.uid,
              spotId: machine.spotId,
              beforePic: url2,
              afterPic: url1,
              futureUpdate: _date.value,
            );
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Finish Service"),
        ),
      ),
    );
  }
}

class ImageSource {}

class InputText extends StatelessWidget {
  final String title;
  const InputText({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title:',
      textScaleFactor: 2,
      style: TextStyle(
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
