import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_bank/models/users_register.dart';

class UserControl {
  final userDB = Supabase.instance.client.from('registeredUsers');

  // create user
  Future<void> createUser(RegisteredUser user) async {
    await userDB.insert(user.toMapUser());
  }

  // delete user
  Future deleteUser(RegisteredUser user) async {
    await userDB.delete().eq('id', user.id!);
  }

  // get user
  Future getCurrentUserData(String accountEmail) {
    return userDB.select().eq('email', accountEmail).limit(1).single();
  }

  // confirming email and password upon login
  Future<bool> confirmUser(String userEmail, int pin) async {
    try {
      final userData =
          await userDB.select().eq('email', userEmail).limit(1).single();
      if (userData['email'] == userEmail && userData['pin_number'] == pin) {
        print('Correct credentials');
        return true;
      } else {
        print('Incorrect credentials');
        return false;
      }
    } on PostgrestException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future userSignOut() async {
    await Supabase.instance.client.auth.signOut();
  }
}
