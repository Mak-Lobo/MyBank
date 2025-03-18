import 'package:supabase_flutter/supabase_flutter.dart'
    show Supabase, SupabaseClient;

class DbSuperbase {
  SupabaseClient user_controller = Supabase.instance.client;

}
