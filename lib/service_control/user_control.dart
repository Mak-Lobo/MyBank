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
  
}
