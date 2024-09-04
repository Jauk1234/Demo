import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:user_repository/src/user_repo.dart';

class SupabaseUserRepo implements UserRepository {
  final supabase = Supabase.instance.client;

  @override
  Stream<User?> get user {
    return supabase.auth.onAuthStateChange.map((event) {
      return event.session?.user;
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      final response = await supabase.auth.signUp(
        password: password,
        email: myUser.email,
      );

      final user = response.user;
      if (user == null) {
        throw Exception('User creation failed');
      }

      myUser = myUser.copyWith(userId: user.id);

      return myUser;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser user) async {
    try {
      final userData = user.toEntity().toDocument();

      await supabase.from('users').upsert(userData);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await supabase.auth.signOut();
  }
}
