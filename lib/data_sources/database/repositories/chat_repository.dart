import 'package:hotspot_chat/data_sources/database/tables/tables.dart';
import 'package:hotspot_chat/models/chat.dart';

import '../tables/data_base_helper.dart';

class ChatRepository {
  static String chatsTable = Tables.chats;

  static Future<void> addChat(Chat chat) async {
    await DatabaseHelper.instance.insert(chatsTable, chat.toJson());
  }

  static Future<bool> isChatExist(String chatId) async {
    Map<String, dynamic>? chat =
        await DatabaseHelper.instance.getFirst(chatsTable, 'id', chatId);
    return chat != null;
  }
}
