import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/user.dart';
import '../services/database.dart';

final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

class UserProvider extends ChangeNotifier {
  late Users _users;

  UserProvider() {
    loadUser();
  }

  Future<void> loadUser() async {
    _users = await DatabaseService.getUser(
      id: FirebaseAuth.instance.currentUser!.uid,
    );
    notifyListeners();
  }

  Future<void> updateUser({
    required String key,
    required dynamic value,
  }) async {
    await DatabaseService.updateUser(
      id: _users.id,
      key: key,
      value: value,
    );

    await loadUser();

    notifyListeners();
  }

  String get id => FirebaseAuth.instance.currentUser!.uid;

  String get type => _users.type;

  Users get user => _users;
}
