import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile extends StateNotifier<UserData?> {
  UserProfile(super.state);

  bool login(String username, String password) {
    // TODO: faccio verifiche super sicure
    if (username.isEmpty || password.isEmpty) {
      return false;
    }

    state = UserData(username);

    return true;
  }

  void logout() {
    state = null;
  }
}

class UserData {
  final String username;

  const UserData(this.username);
}
