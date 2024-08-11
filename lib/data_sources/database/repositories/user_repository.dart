import 'package:hotspot_chat/data_sources/database/tables/data_base_helper.dart';
import 'package:hotspot_chat/models/user.dart';

import '../tables/tables.dart';

class UserRepository {
  static const String userTable = Tables.users;

  static Future<bool> isUserExist(String id) async {
    return await getUser(id) != null;
  }

  static Future<User?> getUser(String id) async {
    Map<String, dynamic>? user = await DatabaseHelper.instance
        .getFirst(userTable, 'device_identifier', id);
    if (user != null) {
      return User.fromJson(user);
    }
    return null;
  }

  static Future<void> addUser(User user) async {
    await DatabaseHelper.instance.insert(userTable, user.toJson());
  }

  static Future<List<User>> getUsers(String currentUserId) async {
    List<Map<String, dynamic>> users = await DatabaseHelper.instance
        .getWhenNot(userTable, 'device_identifier', currentUserId);
    return users.map((e) => User.fromJson(e)).toList();
  }

  static Future<List<User>> getUsersWithout(
      String currentUserId, String otherUserId) async {
    print("currentUserId: $currentUserId, otherUserId: $otherUserId");
    List<Map<String, dynamic>> users = await DatabaseHelper.instance
        .getWhenNot2(
            userTable, 'device_identifier', currentUserId, otherUserId);
    return users.map((e) => User.fromJson(e)).toList();
  }
}
